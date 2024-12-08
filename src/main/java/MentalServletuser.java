import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.sql.Time;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/MentalServletuser")
public class MentalServletuser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";  // Changed DB name to 'name'
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(MentalServletuser.class.getName());

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            logger.log(Level.SEVERE, "Database driver not found", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            createAppointment(request, response);
        } else if ("update".equals(action)) {
            updateAppointment(request, response);
        } else if ("delete".equals(action)) {
            deleteAppointment(request, response);
        }
    }

    private void createAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String counselingType = request.getParameter("counselingType");
        String preferredMethod = request.getParameter("preferredMethod");
        String appointmentDateStr = request.getParameter("appointmentDate");
        String appointmentTimeStr = request.getParameter("appointmentTime");
        String concerns = request.getParameter("concerns");

        // Validate input
        if (fullName == null || fullName.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            counselingType == null || counselingType.trim().isEmpty() || 
            preferredMethod == null || preferredMethod.trim().isEmpty() || 
            appointmentDateStr == null || appointmentTimeStr == null) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating appointment with name: {0}, email: {1}, counselingType: {2}", 
                   new Object[]{fullName, email, counselingType});

        Date appointmentDate;
        Time appointmentTime;

        try {
            // Parse the appointment date
            appointmentDate = Date.valueOf(appointmentDateStr);

            // Handle time format: Ensure it is in HH:mm:ss format (24-hour format)
            appointmentTime = parseTime(appointmentTimeStr);
        } catch (IllegalArgumentException e) {
            // Log and show specific error message
            logger.log(Level.SEVERE, "Invalid date or time format. Date: {0}, Time: {1}", 
                       new Object[]{appointmentDateStr, appointmentTimeStr});
            handleError(response, "Invalid date or time format. Please use the correct format (YYYY-MM-DD for date, HH:mm:ss for time).");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO counseling_appointments (fullName, email, phone, counselingType, preferredMethod, appointmentDate, appointmentTime, concerns) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, counselingType);
                stmt.setString(5, preferredMethod);
                stmt.setDate(6, appointmentDate);
                stmt.setTime(7, appointmentTime);
                stmt.setString(8, concerns);
                stmt.executeUpdate();
                sendSuccessResponse(response, fullName, counselingType, appointmentDateStr, appointmentTimeStr);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred: " + e.getMessage(), e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    // Helper method to parse time and ensure it's in HH:mm:ss format
    private Time parseTime(String appointmentTimeStr) throws IllegalArgumentException {
        if (appointmentTimeStr == null || appointmentTimeStr.trim().isEmpty()) {
            throw new IllegalArgumentException("Time cannot be empty");
        }

        // Split the time string into components (h:mm:ss format)
        String[] timeParts = appointmentTimeStr.split(":");

        if (timeParts.length != 3) {
            throw new IllegalArgumentException("Invalid time format. Expected format h:mm:ss");
        }

        String hour = timeParts[0].trim();
        String minute = timeParts[1].trim();
        String second = timeParts[2].trim();

        // Prepend a 0 to single digit hours (if necessary) to ensure 2 digits
        if (hour.length() == 1) {
            hour = "0" + hour;
        }

        // Construct the time in HH:mm:ss format
        String timeFormatted = hour + ":" + minute + ":" + second;

        // Return the Time object
        return Time.valueOf(timeFormatted);
    }


    private void updateAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String counselingType = request.getParameter("counselingType");
        String preferredMethod = request.getParameter("preferredMethod");
        String appointmentDateStr = request.getParameter("appointmentDate");
        String appointmentTimeStr = request.getParameter("appointmentTime");
        String concerns = request.getParameter("concerns");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE counseling_appointments SET fullName=?, email=?, phone=?, counselingType=?, preferredMethod=?, appointmentDate=?, appointmentTime=?, concerns=? WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, fullName);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, counselingType);
                stmt.setString(5, preferredMethod);
                stmt.setDate(6, Date.valueOf(appointmentDateStr));
                stmt.setTime(7, Time.valueOf(appointmentTimeStr));
                stmt.setString(8, concerns);
                stmt.setInt(9, appointmentId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Appointment updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No appointment found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteAppointment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int appointmentId = Integer.parseInt(request.getParameter("appointment_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM counseling_appointments WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, appointmentId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteAppointment.jsp?success=true");
                } else {
                    response.sendRedirect("deleteAppointment.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveAppointments(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM counseling_appointments";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Appointments</h2><table border='1'><tr><th>Appointment ID</th><th>Full Name</th><th>Email</th><th>Phone</th><th>Counseling Type</th><th>Preferred Method</th><th>Appointment Date</th><th>Appointment Time</th><th>Concerns</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='9'>No appointments found.</td></tr>");
            } else {
                while (rs.next()) {
                    int appointmentId = rs.getInt("id");
                    String fullName = rs.getString("fullName");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String counselingType = rs.getString("counselingType");
                    String preferredMethod = rs.getString("preferredMethod");
                    Date appointmentDate = rs.getDate("appointmentDate");
                    Time appointmentTime = rs.getTime("appointmentTime");
                    String concerns = rs.getString("concerns");

                    out.println("<tr><td>" + appointmentId + "</td><td>" + fullName + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + counselingType + "</td><td>" + preferredMethod + "</td><td>" + appointmentDate + "</td><td>" + appointmentTime + "</td><td>" + concerns + "</td></tr>");
                }
            }

            out.println("</table><p><a href='admindashboard.jsp'>Back to Dashboard</a></p></body></html>");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            retrieveAppointments(response);
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String fullName, String counselingType, String appointmentDate, String appointmentTime) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Appointment successfully booked!</h3>");
            out.println("  Appointment for " + counselingType + " on " + appointmentDate + " at " + appointmentTime + " has been successfully scheduled.</p>");
            out.println("<p><a href='addcounselinguser.jsp'>Back to Appointment Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='addcounselinguser.jsp'>Back to Appointment Form</a></p>");
            out.println("</body></html>");
        }
    }
}
