import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/YouthServletuser")
public class YouthServletuser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(YouthServlet.class.getName());

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
            createYouthCampRegistration(request, response);
        } else if ("update".equals(action)) {
            updateYouthCampRegistration(request, response);
        } else if ("delete".equals(action)) {
            deleteYouthCampRegistration(request, response);
        }
    }

    private void createYouthCampRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String camp = request.getParameter("camp");
        String tshirtSize = request.getParameter("tshirt_size");
        String allergies = request.getParameter("allergies");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            camp == null || camp.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating youth camp registration for: {0}, email: {1}, camp: {2}", 
                   new Object[]{name, email, camp});

        Date registrationDate = new Date(System.currentTimeMillis()); // Using current date for registration

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO youth_camp_registrations (name, email, phone, age, gender, camp, tshirt_size, allergies, emergency_contact_name, emergency_contact_phone, comments, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, camp);
                stmt.setString(7, tshirtSize);
                stmt.setString(8, allergies);
                stmt.setString(9, emergencyContactName);
                stmt.setString(10, emergencyContactPhone);
                stmt.setString(11, comments);
                
                stmt.executeUpdate();

                // Retrieve the generated registration ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int registrationId = generatedKeys.getInt(1); // Get the generated ID
                        sendSuccessResponse(response, name, camp, registrationDate.toString(), registrationId);
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

    private void updateYouthCampRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String age = request.getParameter("age");
        String gender = request.getParameter("gender");
        String camp = request.getParameter("camp");
        String tshirtSize = request.getParameter("tshirt_size");
        String allergies = request.getParameter("allergies");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");
        String status = request.getParameter("status");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE youth_camp_registrations SET name=?, email=?, phone=?, age=?, gender=?, camp=?, tshirt_size=?, allergies=?, emergency_contact_name=?, emergency_contact_phone=?, comments=?, status=? WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setString(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, camp);
                stmt.setString(7, tshirtSize);
                stmt.setString(8, allergies);
                stmt.setString(9, emergencyContactName);
                stmt.setString(10, emergencyContactPhone);
                stmt.setString(11, comments);
                stmt.setString(12, status);
                stmt.setInt(13, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Youth camp registration updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No registration found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteYouthCampRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM youth_camp_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteYouth.jsp?success=true");
                } else {
                    response.sendRedirect("deleteYouth.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveYouthCampRegistrations(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM youth_camp_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Registrations</h2><table border='1'><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Age</th><th>Gender</th><th>Camp</th><th>T-Shirt Size</th><th>Allergies</th><th>Emergency Contact Name</th><th>Emergency Contact Phone</th><th>Comments</th><th>Status</th><th>Actions</th></tr>");

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
                    String camp = rs.getString("camp");
                    String tshirtSize = rs.getString("tshirt_size");
                    String allergies = rs.getString("allergies");
                    String emergencyContactName = rs.getString("emergency_contact_name");
                    String emergencyContactPhone = rs.getString("emergency_contact_phone");
                    String comments = rs.getString("comments");
                    Date registrationDate = rs.getDate("registration_date");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + registrationId + "</td><td>" + name + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + age + "</td><td>" + gender + "</td><td>" + camp + "</td><td>" + tshirtSize + "</td><td>" + allergies + "</td><td>" + emergencyContactName + "</td><td>" + emergencyContactPhone + "</td><td>" + comments + "</td><td>" + registrationDate + "</td><td>" + status + "</td><td><a href='updateYouth.jsp?id=" + registrationId + "'>Edit</a> | <a href='deleteYouth.jsp?id=" + registrationId + "'>Delete</a></td></tr>");
                }
            }
            out.println("</table></body></html>");
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
            out.println("<p><a href='viewYouthbookings.jsp'>Click here to see the status of your registration</a></p>");
            out.println("<p><a href='youthcampreg.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='youthcampreg.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }
}

