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

@WebServlet("/IntramuralServletuser")
public class IntramuralServletuser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(IntramuralServletuser.class.getName());

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
            createIntramuralRegistration(request, response);
        } else if ("update".equals(action)) {
            updateIntramuralRegistration(request, response);
        } else if ("delete".equals(action)) {
            deleteIntramuralRegistration(request, response);
        }
    }

    private void createIntramuralRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String sport = request.getParameter("sport");
        String details = request.getParameter("details");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            sport == null || sport.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating intramural registration with name: {0}, email: {1}, phone: {2}, sport: {3}", 
                   new Object[]{name, email, phone, sport});

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO intramural_registrations (name, email, phone, sport, status) VALUES (?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, sport);
                stmt.executeUpdate();

                // Retrieve the generated registration ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int registrationId = generatedKeys.getInt(1); // Get the generated ID
                        sendSuccessResponse(response, name, sport, registrationId);
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

    private void updateIntramuralRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String sport = request.getParameter("sport");
        String details = request.getParameter("details");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET name=?, email=?, phone=?, sport=?, details=? WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, sport);
                stmt.setString(5, details);
                stmt.setInt(6, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Intramural registration updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No registration found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteIntramuralRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM intramural_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteIntramural.jsp?success=true");
                } else {
                    response.sendRedirect("deleteIntramural.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveIntramuralRegistrations(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM intramural_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Intramural Registrations</h2><table border='1'><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Sport</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='7'>No registrations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int registrationId = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String sport = rs.getString("sport");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + registrationId + "</td><td>" + name + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + sport + "</td><td>" + status + "</td>");
                    out.println("<td><a href='IntramuralServletuser?action=accept&id=" + registrationId + "'>Accept</a> | "
                              + "<a href='IntramuralServletuser?action=reject&id=" + registrationId + "'>Reject</a></td></tr>");
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
            retrieveIntramuralRegistrations(response);
        } else if ("accept".equals(action)) {
            acceptIntramuralRegistration(request, response);
        } else if ("reject".equals(action)) {
            rejectIntramuralRegistration(request, response);
        }
    }

    private void acceptIntramuralRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET status='Accepted' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("IntramuralServletuser?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void rejectIntramuralRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET status='Rejected' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("IntramuralServletuser?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String sport, int registrationId) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Registration successful!</h3>");
            out.println("<p>Thank you, " + name + ". Your registration for the sport " + sport + " has been received.</p>");
            out.println("<p>Your application is sent for approval.</p>");
            out.println("<p>Your registration ID is: " + registrationId + "</p>"); // Display the registration ID
            out.println("<p><a href='viewIntramuralbookings.jsp'>Click here to see the status of your booking</a></p>");
            out.println("<p><a href='intramuralreg.jsp'>Back to Reservation Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='intramuralreg.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }
}
