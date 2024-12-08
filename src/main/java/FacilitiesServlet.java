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

@WebServlet("/FacilitiesServlet")
public class FacilitiesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(FacilitiesServlet.class.getName());

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
            createFacility(request, response);
        } else if ("update".equals(action)) {
            updateFacility(request, response);
        } else if ("delete".equals(action)) {
            deleteFacility(request, response);
        }
    }

    private void createFacility(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String facility = request.getParameter("facility");
        String reservationDateStr = request.getParameter("reservation_date");
        String reservationTimeStr = request.getParameter("reservation_time");
        String details = request.getParameter("details");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            facility == null || facility.trim().isEmpty() || 
            reservationDateStr == null || reservationTimeStr == null) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating facility with name: {0}, email: {1}, facility: {2}", 
                   new Object[]{name, email, facility});

        Date reservationDate;
        Time reservationTime;
        try {
            reservationDate = Date.valueOf(reservationDateStr);
            reservationTime = Time.valueOf(reservationTimeStr);
        } catch (IllegalArgumentException e) {
            handleError(response, "Invalid date or time format.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO facility_reservations2 (name, email, facility, reservation_date, reservation_time, details, status) VALUES (?, ?, ?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, facility);
                stmt.setDate(4, reservationDate);
                stmt.setTime(5, reservationTime);
                stmt.setString(6, details);
                stmt.executeUpdate();
                sendSuccessResponse(response, name, facility, reservationDateStr, reservationTimeStr);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred: {0}", e.getMessage());
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void updateFacility(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String facility = request.getParameter("facility");
        String reservationDateStr = request.getParameter("reservation_date");
        String reservationTimeStr = request.getParameter("reservation_time");
        String details = request.getParameter("details");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE facility_reservations2 SET name=?, email=?, facility=?, reservation_date=?, reservation_time=?, details=? WHERE reservation_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, facility);
                stmt.setDate(4, Date.valueOf(reservationDateStr));
                stmt.setTime(5, Time.valueOf(reservationTimeStr));
                stmt.setString(6, details);
                stmt.setInt(7, reservationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Facility updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No reservation found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteFacility(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM facility_reservations2 WHERE reservation_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, reservationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteFacility.jsp?success=true");
                } else {
                    response.sendRedirect("deleteFacility.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveFacilities(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM facility_reservations2";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Reservations</h2><table border='1'><tr><th>Reservation ID</th><th>Name</th><th>Email</th><th>Facility</th><th>Reservation Date</th><th>Reservation Time</th><th>Details</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='9'>No reservations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int reservationId = rs.getInt("reservation_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String facility = rs.getString("facility");
                    Date reservationDate = rs.getDate("reservation_date");
                    Time reservationTime = rs.getTime("reservation_time");
                    String details = rs.getString("details");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + reservationId + "</td><td>" + name + "</td><td>" + email + "</td><td>" + facility + "</td><td>" + reservationDate + "</td><td>" + reservationTime + "</td><td>" + details + "</td><td>" + status + "</td>");
                    out.println("<td><a href='FacilitiesServlet?action=accept&reservation_id=" + reservationId + "'>Accept</a> | "
                              + "<a href='FacilitiesServlet?action=reject&reservation_id=" + reservationId + "'>Reject</a></td></tr>");
                }
            }

            out.println("</table><p><a href='admin_dashboard.jsp'>Back to Dashboard</a></p></body></html>");
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
            retrieveFacilities(response);
        } else if ("accept".equals(action)) {
            acceptFacility(request, response);
        } else if ("reject".equals(action)) {
            rejectFacility(request, response);
        }
    }

    private void acceptFacility(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE facility_reservations2 SET status='Accepted' WHERE reservation_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, reservationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("FacilitiesServlet?action=view");
                } else {
                    handleError(response, "No reservation found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void rejectFacility(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int reservationId = Integer.parseInt(request.getParameter("reservation_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE facility_reservations2 SET status='Rejected' WHERE reservation_id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, reservationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("FacilitiesServlet?action=view");
                } else {
                    handleError(response, "No reservation found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String facility, String reservationDate, String reservationTime) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Reservation successful!</h3>");
            out.println("  Reservation for " + facility + " on " + reservationDate + " at " + reservationTime + " has been booked.</p>");
            
            out.println("<p><a href='facilities.jsp'>Back to Reservation Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='facilities.jsp'>Back to Reservation Form</a></p>");
            out.println("</body></html>");
        }
    }
}
