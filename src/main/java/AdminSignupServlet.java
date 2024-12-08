import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.mindrot.jbcrypt.BCrypt;
import java.sql.ResultSet;

@WebServlet("/AdminSignupServlet")
public class AdminSignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String googleSignIn = request.getParameter("googleSignIn"); // Check if it's a Google sign-in

        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_health_wellness", "root", "GSK&ydk1")) {

                if ("true".equals(googleSignIn)) {
                    // If signing in with Google, skip the username check and insert directly
                    // You should already have username and email from the Google OAuth process
                    String insertQuery = "INSERT INTO adminusers (username, email) VALUES (?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, email);
                    
                    int result = insertStmt.executeUpdate();
                    if (result > 0) {
                        response.sendRedirect("success.jsp?username=" + username + "&email=" + email);
                    } else {
                        response.sendRedirect("adminsignup.jsp?error=Registration failed");
                    }
                } else {
                    // Traditional signup flow
                    // Check if the username already exists
                    String checkQuery = "SELECT COUNT(*) FROM adminusers WHERE username=?";
                    PreparedStatement checkStmt = conn.prepareStatement(checkQuery);
                    checkStmt.setString(1, username);
                    ResultSet checkRs = checkStmt.executeQuery();
                    checkRs.next();
                    if (checkRs.getInt(1) > 0) {
                        response.sendRedirect("adminsignup.jsp?error=User already exists");
                        return;
                    }

                    // Hash the password
                    

                    // Insert new user into database
                    String insertQuery = "INSERT INTO adminusers (username, email, password) VALUES (?, ?, ?)";
                    PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, email);
                    insertStmt.setString(3, password);
                    
                    int result = insertStmt.executeUpdate();
                    if (result > 0) {
                        response.sendRedirect("adminlogin.jsp?success=Registration successful");
                    } else {
                        response.sendRedirect("adminsignup.jsp?error=Registration failed");
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminsignup.jsp?error=General error occurred");
        }
    }
}
