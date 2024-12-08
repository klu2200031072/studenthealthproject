import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/FitnessClassServletUser")
public class FitnessClassServletUser extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(FitnessClassServletUser.class.getName());

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
            createFitnessClassRegistration(request, response);
        } else if ("update".equals(action)) {
            updateFitnessClassRegistration(request, response);
        } else if ("delete".equals(action)) {
            deleteFitnessClassRegistration(request, response);
        }
    }

    private void createFitnessClassRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String fitnessClass = request.getParameter("fitness_class");
        String trainingType = request.getParameter("training_type");
        String experience = request.getParameter("experience");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || 
            phone == null || phone.trim().isEmpty() || 
            fitnessClass == null || fitnessClass.trim().isEmpty() || 
            trainingType == null || trainingType.trim().isEmpty() || 
            experience == null || experience.trim().isEmpty() || 
            emergencyContactName == null || emergencyContactName.trim().isEmpty() || 
            emergencyContactPhone == null || emergencyContactPhone.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating fitness class registration for: {0}, email: {1}, fitness class: {2}", 
                   new Object[]{name, email, fitnessClass});

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO fitness_class_registrations (name, email, phone, age, gender, fitness_class, training_type, experience, emergency_contact_name, emergency_contact_phone, comments, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setInt(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, fitnessClass);
                stmt.setString(7, trainingType);
                stmt.setString(8, experience);
                stmt.setString(9, emergencyContactName);
                stmt.setString(10, emergencyContactPhone);
                stmt.setString(11, comments);
                stmt.executeUpdate();

                // Retrieve the generated registration ID
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int registrationId = generatedKeys.getInt(1); // Get the generated ID
                        sendSuccessResponse(response, name, fitnessClass, registrationId);
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

    private void updateFitnessClassRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("registration_id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");
        String fitnessClass = request.getParameter("fitness_class");
        String trainingType = request.getParameter("training_type");
        String experience = request.getParameter("experience");
        String emergencyContactName = request.getParameter("emergency_contact_name");
        String emergencyContactPhone = request.getParameter("emergency_contact_phone");
        String comments = request.getParameter("comments");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE fitness_class_registrations SET name=?, email=?, phone=?, age=?, gender=?, fitness_class=?, training_type=?, experience=?, emergency_contact_name=?, emergency_contact_phone=?, comments=? WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email);
                stmt.setString(3, phone);
                stmt.setInt(4, age);
                stmt.setString(5, gender);
                stmt.setString(6, fitnessClass);
                stmt.setString(7, trainingType);
                stmt.setString(8, experience);
                stmt.setString(9, emergencyContactName);
                stmt.setString(10, emergencyContactPhone);
                stmt.setString(11, comments);
                stmt.setInt(12, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("<h3>Registration updated successfully.</h3>");
                } else {
                    response.getWriter().println("<h3>No registration found with that ID.</h3>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void deleteFitnessClassRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("registration_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM fitness_class_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteFitnessClass.jsp?success=true");
                } else {
                    response.sendRedirect("deleteFitnessClass.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void retrieveFitnessClassRegistrations(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM fitness_class_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Registrations</h2><table border='1'><tr><th>Registration ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Age</th><th>Gender</th><th>Fitness Class</th><th>Training Type</th><th>Experience</th><th>Emergency Contact</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='12'>No registrations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int registrationId = rs.getInt("id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    int age = rs.getInt("age");
                    String gender = rs.getString("gender");
                    String fitnessClass = rs.getString("fitness_class");
                    String trainingType = rs.getString("training_type");
                    String experience = rs.getString("experience");
                    String emergencyContactName = rs.getString("emergency_contact_name");
                    String emergencyContactPhone = rs.getString("emergency_contact_phone");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + registrationId + "</td><td>" + name + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + age + "</td><td>" + gender + "</td><td>" + fitnessClass + "</td><td>" + trainingType + "</td><td>" + experience + "</td><td>" + emergencyContactName + " (" + emergencyContactPhone + ")</td><td>" + status + "</td>");
                    out.println("<td><a href='FitnessClassServletUser?action=accept&registration_id=" + registrationId + "'>Accept</a> | "
                              + "<a href='FitnessClassServletUser?action=reject&registration_id=" + registrationId + "'>Reject</a></td></tr>");
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
            retrieveFitnessClassRegistrations(response);
        } else if ("accept".equals(action)) {
            acceptFitnessClassRegistration(request, response);
        } else if ("reject".equals(action)) {
            rejectFitnessClassRegistration(request, response);
        }
    }

    private void acceptFitnessClassRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("registration_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE fitness_class_registrations SET status='Accepted' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("FitnessClassServletUser?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void rejectFitnessClassRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE fitness_class_registrations SET status='Rejected' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("FitnessClassServletUser?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String fitnessClass, int registrationId) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Registration successful!</h3>");
            out.println("<p>Thank you, " + name + ". Your registration for the " + fitnessClass + " class has been received.</p>");
            out.println("<p>Your application is sent for approval.</p>");
            out.println("<p>Your registration ID is: " + registrationId + "</p>"); // Display the registration ID
            out.println("<p><a href='viewfitnessbookings.jsp'>Click here to see the status of your booking</a></p>");
            out.println("<p><a href='fitness_classes.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='fitness_classes.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }
}
