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

@WebServlet("/SportServletuser")
public class SportServletuser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(SportServletuser.class.getName());

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
            createSportClubRegistration(request, response);
        } else if ("update".equals(action)) {
            updateSportClubRegistration(request, response);
        } else if ("delete".equals(action)) {
            deleteSportClubRegistration(request, response);
        }
    }

    private void createSportClubRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String experience = request.getParameter("experience");
        String sport = request.getParameter("sport");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            sport == null || sport.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating sport club registration for: {0}, email: {1}, sport: {2}", 
                   new Object[]{name, email, sport});

        Date registrationDate = new Date(System.currentTimeMillis()); // Using current date for registration

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO sport_club_registrations (name, email, phone, age, gender, experience, sport, emergency_contact_name, emergency_contact_phone, comments, registration_date, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, experience);
                stmt.setString(7, sport);
                stmt.setString(8, emergencyContactName);
                stmt.setString(9, emergencyContactPhone);
                stmt.setString(10, comments);
                stmt.setDate(11, registrationDate);
                stmt.executeUpdate();

                // Retrieve the generated registration ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int registrationId = generatedKeys.getInt(1); // Get the generated ID
                        sendSuccessResponse(response, name, sport, registrationDate.toString(), registrationId);
                    } else {
                        handleError(response, "Failed to retrieve registration ID.");
                    }
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred: {0}", e.getMessage());
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void updateSportClubRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String experience = request.getParameter("experience");
        String sport = request.getParameter("sport");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE sport_club_registrations SET name=?, email=?, phone=?, age=?, gender=?, experience=?, sport=?, emergency_contact_name=?, emergency_contact_phone=?, comments=? WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, experience);
                stmt.setString(7, sport);
                stmt.setString(8, emergencyContactName);
                stmt.setString(9, emergencyContactPhone);
                stmt.setString(10, comments);
                stmt.setInt(11, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Sport club registration updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No registration found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteSportClubRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM sport_club_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteSport.jsp?success=true");
                } else {
                    response.sendRedirect("deleteSport.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveSportClubRegistrations(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM sport_club_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Registrations</h2><table border='1'><tr><th>Registration ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Age</th><th>Gender</th><th>Experience</th><th>Sport</th><th>Emergency Contact Name</th><th>Emergency Contact Phone</th><th>Comments</th><th>Registration Date</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='14'>No registrations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int registrationId = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String age = rs.getString("age");
                    String gender = rs.getString("gender");
                    String experience = rs.getString("experience");
                    String sport = rs.getString("sport");
                    String emergencyContactName = rs.getString("emergency_contact_name");
                    String emergencyContactPhone = rs.getString("emergency_contact_phone");
                    String comments = rs.getString("comments");
                    Date registrationDate = rs.getDate("registration_date");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + registrationId + "</td><td>" + name + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + age + "</td><td>" + gender + "</td><td>" + experience + "</td><td>" + sport + "</td><td>" + emergencyContactName + "</td><td>" + emergencyContactPhone + "</td><td>" + comments + "</td><td>" + registrationDate + "</td><td>" + status + "</td>");
                    out.println("<td><a href='SportServlet?action=accept&id=" + registrationId + "'>Accept</a> | "
                              + "<a href='SportServlet?action=reject&id=" + registrationId + "'>Reject</a></td></tr>");
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
            retrieveSportClubRegistrations(response);
        } else if ("accept".equals(action)) {
            acceptSportClubRegistration(request, response);
        } else if ("reject".equals(action)) {
            rejectSportClubRegistration(request, response);
        }
    }

    private void acceptSportClubRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE sport_club_registrations SET status='Accepted' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("SportServlet?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void rejectSportClubRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE sport_club_registrations SET status='Rejected' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("SportServlet?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String sport, String registrationDate, int registrationId) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Registration successful!</h3>");
            out.println("<p>Thank you, " + name + ". Your registration for " + sport + " on " + registrationDate + " has been received.</p>");
            out.println("<p>Your application is sent for approval.</p>");
            out.println("<p>Your registration ID is: " + registrationId + "</p>"); // Display the registration ID
            out.println("<p><a href='viewSportbookings.jsp'>Click here to see the status of your registration</a></p>");
            out.println("<p><a href='sportclubreg.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='sportclubreg.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }
}
