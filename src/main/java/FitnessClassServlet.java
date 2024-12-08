import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FitnessClassServlet")
public class FitnessClassServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(FitnessClassServlet.class.getName());

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
            createRegistration(request, response);
        } else if ("update".equals(action)) {
            updateRegistration(request, response);
        } else if ("delete".equals(action)) {
            deleteRegistration(request, response);
        }
    }

    private void createRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String ageStr = request.getParameter("age");
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
            ageStr == null || ageStr.trim().isEmpty() || 
            gender == null || gender.trim().isEmpty() || 
            fitnessClass == null || fitnessClass.trim().isEmpty() || 
            trainingType == null || trainingType.trim().isEmpty() || 
            experience == null || experience.trim().isEmpty() || 
            emergencyContactName == null || emergencyContactName.trim().isEmpty() || 
            emergencyContactPhone == null || emergencyContactPhone.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        int age = Integer.parseInt(ageStr);  // Parse age to integer

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO fitness_class_registrations (name, email, phone, age, gender, fitness_class, " +
                         "training_type, experience, emergency_contact_name, emergency_contact_phone, comments, status) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 'Pending')";
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
                stmt.executeUpdate();
                sendSuccessResponse(response, name, fitnessClass);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void updateRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));
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
            // Update query using the provided column names from the `fitness_class_registrations` table
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

    private void deleteRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM fitness_class_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);
                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    response.sendRedirect("deleteFitness.jsp?success=true");
                } else {
                    response.sendRedirect("deleteFitness.jsp?error=not_found");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String fitnessClass) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Registration successful!</h3>");
            out.println("  Registration for " + fitnessClass + " by " + name + " has been booked successfully.</p>");
            out.println("<p><a href='register.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='register.jsp'>Back to Registration Form</a></p>");
            out.println("</body></html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("view".equals(action)) {
            retrieveRegistrations(response);
        }
    }

    private void retrieveRegistrations(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM fitness_class_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Registrations</h2><table border='1'><tr><th>ID</th><th>Name</th><th>Email</th><th>Phone</th><th>Age</th><th>Gender</th><th>Class</th><th>Training</th><th>Experience</th><th>Emergency Contact</th><th>Phone</th><th>Comments</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='14'>No registrations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int id = rs.getInt("id");
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
                    String comments = rs.getString("comments");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + id + "</td><td>" + name + "</td><td>" + email + "</td><td>" + phone + "</td><td>" + age + "</td><td>" + gender + "</td><td>" + fitnessClass + "</td><td>" + trainingType + "</td><td>" + experience + "</td><td>" + emergencyContactName + "</td><td>" + emergencyContactPhone + "</td><td>" + comments + "</td><td>" + status + "</td>");
                    out.println("<td><a href='FitnessClassServlet?action=accept&id=" + id + "'>Accept</a> | "
                              + "<a href='FitnessClassServlet?action=reject&id=" + id + "'>Reject</a></td></tr>");
                }
            }

            out.println("</table><p><a href='admindashboard.jsp'>Back to Dashboard</a></p></body></html>");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }
}
