import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/AdminResetPasswordServlet")
public class AdminResetPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("new_password");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("email");

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_health_wellness", "root", "GSK&ydk1");

            String query = "UPDATE adminusers SET password=? WHERE email=?";
            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, newPassword); // Hash this password before storing
            stmt.setString(2, email);

            int rowsUpdated = stmt.executeUpdate();
            if (rowsUpdated > 0) {
                response.sendRedirect("adminlogin.jsp?reset=success"); // Redirect to login page with success message
            } else {
                response.sendRedirect("adminreset_password.jsp?error=1"); // Redirect back with error
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
