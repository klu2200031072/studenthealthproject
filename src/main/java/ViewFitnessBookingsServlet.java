import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ViewFitnessBookingsServlet")
public class ViewFitnessBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String registrationIdStr = request.getParameter("id");
        String message = null;
        String error = null;

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT status FROM fitness_class_registrations WHERE id=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, Integer.parseInt(registrationIdStr));
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String status = rs.getString("status");
                        if ("Accepted".equalsIgnoreCase(status)) {
                            message = "Congratulations, your registration is accepted!";
                        } else if ("Rejected".equalsIgnoreCase(status)) {
                            message = "Sorry, your registration was rejected.";
                        } else {
                            message = "The status of your registration is pending.";
                        }
                    } else {
                        error = "No registration found with that ID.";
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = "An error occurred while accessing the database.";
        }
        request.setAttribute("message", message);
        request.setAttribute("error", error);
        request.getRequestDispatcher("viewfitnessbookings.jsp").forward(request, response);
    }
}
