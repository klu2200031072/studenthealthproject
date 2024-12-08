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

@WebServlet("/IntramuralServlet")
public class IntramuralServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(IntramuralServlet.class.getName());

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
            createIntramural(request, response);
        } else if ("update".equals(action)) {
            updateIntramural(request, response);
        } else if ("delete".equals(action)) {
            deleteIntramural(request, response);
        }
    }

    private void createIntramural(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email"); // changed to 'email' as per the new columns
        String phone = request.getParameter("phone");
        String sport = request.getParameter("sport");

        // Validate input
        if (name == null || name.trim().isEmpty() || 
            email == null || email.trim().isEmpty() || // added validation for email
            phone == null || phone.trim().isEmpty() || 
            sport == null || sport.trim().isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        logger.log(Level.INFO, "Creating intramural registration with name: {0}, email: {1}, phone: {2}, sport: {3}", 
                   new Object[]{name, email, phone, sport});

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO intramural_registrations (name, email, phone, sport, status) VALUES (?, ?, ?, ?, 'Pending')";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, email); // changed to set email
                stmt.setString(3, phone);
                stmt.setString(4, sport);
                stmt.executeUpdate();
                sendSuccessResponse(response, name, sport);
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred: {0}", e.getMessage());
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }


    private void updateIntramural(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id")); // Updated to "id"
        String name = request.getParameter("name");
        String phone = request.getParameter("phone"); // Updated to "phone"
        String sport = request.getParameter("sport"); // Updated to "sport"
        String status = request.getParameter("status"); // Updated to "status"

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET name=?, phone=?, sport=?, status=? WHERE id=?"; // Updated table and column names
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, phone); // Updated to "phone"
                stmt.setString(3, sport); // Updated to "sport"
                stmt.setString(4, status); // Updated to "status"
                stmt.setInt(5, registrationId); // Updated to "id"
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

    private void deleteIntramural(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));  // Changed to "id"

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "DELETE FROM intramural_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);  // Changed to "id"
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

    private void retrieveIntramurals(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM intramural_registrations";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>All Registrations</h2><table border='1'><tr><th>Registration ID</th><th>Name</th><th>Phone</th><th>Sport</th><th>Status</th><th>Actions</th></tr>");

            if (!rs.isBeforeFirst()) {
                out.println("<tr><td colspan='6'>No registrations found.</td></tr>");
            } else {
                while (rs.next()) {
                    int registrationId = rs.getInt("id");  // Changed to "id"
                    String name = rs.getString("name");
                    String phone = rs.getString("phone");
                    String sport = rs.getString("sport");
                    String status = rs.getString("status");

                    out.println("<tr><td>" + registrationId + "</td><td>" + name + "</td><td>" + phone + "</td><td>" + sport + "</td><td>" + status + "</td>");
                    out.println("<td><a href='IntramuralServlet?action=accept&id=" + registrationId + "'>Accept</a> | "
                              + "<a href='IntramuralServlet?action=reject&id=" + registrationId + "'>Reject</a></td></tr>");
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
            retrieveIntramurals(response);
        } else if ("accept".equals(action)) {
            acceptIntramural(request, response);
        } else if ("reject".equals(action)) {
            rejectIntramural(request, response);
        }
    }

    private void acceptIntramural(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));  // Changed to "id"

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET status='Accepted' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);  // Changed to "id"
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("IntramuralServlet?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void rejectIntramural(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int registrationId = Integer.parseInt(request.getParameter("id"));  // Changed to "id"

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE intramural_registrations SET status='Rejected' WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, registrationId);  // Changed to "id"
                int rowsUpdated = stmt.executeUpdate();

                if (rowsUpdated > 0) {
                    response.sendRedirect("IntramuralServlet?action=view");
                } else {
                    handleError(response, "No registration found with that ID.");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private void handleError(HttpServletResponse response, String errorMessage) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body><h3>Error: " + errorMessage + "</h3></body></html>");
    }

    private void sendSuccessResponse(HttpServletResponse response, String name, String sport) throws IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        out.println("<html><body><h3>Registration for " + name + " in sport " + sport + " was successful.</h3></body></html>");
    }
}
