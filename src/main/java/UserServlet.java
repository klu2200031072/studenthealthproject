import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UserServlet.class.getName());
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "view":
                viewUsers(response);
                break;
            case "edit":
                editUser(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
            default:
                viewUsers(response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        switch (action) {
            case "create":
                createUser(request, response);
                break;
            case "update":
                updateUser(request, response);
                break;
        }
    }

    private void viewUsers(HttpServletResponse response) throws IOException {
        String sql = "SELECT * FROM users";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery();
             PrintWriter out = response.getWriter()) {

            out.println("<html><body><h2>Users List</h2><a href='addUser.jsp'>Add User</a><table border='1'>");
            out.println("<tr><th>ID</th><th>Username</th><th>Password</th><th>Email</th></tr>");

            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");

                out.println("<tr><td>" + id + "</td><td>" + username + "</td><td>" + email + "</td>");
                out.println("<td><a href='UserServlet?action=edit&id=" + id + "'>Edit</a> | ");
                out.println("<a href='UserServlet?action=delete&id=" + id + "'>Delete</a></td></tr>");
            }

            out.println("</table></body></html>");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
        }
    }

    private void createUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        String sql = "INSERT INTO users (username, password, email) VALUES (?, ?, ?)";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);

            stmt.executeUpdate();
            response.sendRedirect("UserServlet?action=view");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
        }
    }

    private void editUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String sql = "SELECT * FROM users WHERE id = ?";
        response.setContentType("text/html");

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery();
                 PrintWriter out = response.getWriter()) {

                if (rs.next()) {
                    out.println("<html><body><h2>Edit User</h2>");
                    out.println("<form method='POST' action='UserServlet?action=update'>");
                    out.println("<input type='hidden' name='id' value='" + id + "' />");
                    out.println("Username: <input type='text' name='username' value='" + rs.getString("username") + "' /><br>");
                    out.println("Password: <input type='password' name='password' value='" + rs.getString("password") + "' /><br>");
                    out.println("Email: <input type='email' name='email' value='" + rs.getString("email") + "' /><br>");
                    out.println("<input type='submit' value='Update' />");
                    out.println("</form></body></html>");
                } else {
                    out.println("<html><body><h3>User not found!</h3></body></html>");
                }
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        String sql = "UPDATE users SET username = ?, password = ?, email = ? WHERE id = ?";
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);
            stmt.setString(3, email);
            stmt.setInt(4, id);

            stmt.executeUpdate();
            response.sendRedirect("UserServlet?action=view");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            // Handle error: no ID provided
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h3>Error: No ID provided for deletion!</h3>");
            out.println("<p><a href='UserServlet?action=view'>Back to Users List</a></p></body></html>");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);

            String sql = "DELETE FROM users WHERE id = ?";
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(sql)) {

                stmt.setInt(1, id);
                int rowsAffected = stmt.executeUpdate();

                if (rowsAffected > 0) {
                    response.sendRedirect("UserServlet?action=view");
                } else {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<html><body><h3>Error: User with ID " + id + " not found.</h3>");
                    out.println("<p><a href='UserServlet?action=view'>Back to Users List</a></p></body></html>");
                }
            }
        } catch (NumberFormatException e) {
            logger.log(Level.SEVERE, "Invalid ID format", e);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h3>Error: Invalid ID format!</h3>");
            out.println("<p><a href='UserServlet?action=view'>Back to Users List</a></p></body></html>");
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            out.println("<html><body><h3>Error: Database issue occurred. Please try again later.</h3>");
            out.println("<p><a href='UserServlet?action=view'>Back to Users List</a></p></body></html>");
        }
    }}
