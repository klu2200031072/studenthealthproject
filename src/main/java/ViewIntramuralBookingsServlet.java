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

@WebServlet("/ViewIntramuralBookingsServlet")
public class ViewIntramuralBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reservationIdStr = request.getParameter("id"); // ID input from user
        String message = null;
        String error = null;

        // Ensure reservation ID is provided
        if (reservationIdStr == null || reservationIdStr.isEmpty()) {
            error = "Reservation ID is required.";
        } else {
            try {
                int reservationId = Integer.parseInt(reservationIdStr);  // Validate input

                // Establish DB connection
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    // Updated SQL query for the new table
                    String sql = "SELECT status FROM intramural_registrations WHERE id=?";
                    try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                        stmt.setInt(1, reservationId);
                        try (ResultSet rs = stmt.executeQuery()) {
                            if (rs.next()) {
                                String status = rs.getString("status");

                                // Check status and set appropriate message
                                switch (status.toLowerCase()) {
                                    case "accepted":
                                        message = "Congratulations, your reservation is accepted!";
                                        break;
                                    case "rejected":
                                        message = "Sorry, your reservation was rejected.";
                                        break;
                                    default:
                                        message = "The status of your reservation is pending.";
                                }
                            } else {
                                error = "No booking found with that ID.";
                            }
                        }
                    }
                }
            } catch (NumberFormatException e) {
                error = "Invalid Reservation ID format. Please enter a valid number.";
            } catch (Exception e) {
                e.printStackTrace();  // Log the error for debugging
                error = "An error occurred while accessing the database.";
            }
        }

        // Set the message or error to be forwarded to the JSP page
        request.setAttribute("message", message);
        request.setAttribute("error", error);

        // Forward the response to the JSP page (viewbookings.jsp)
        request.getRequestDispatcher("viewIntramuralbookings.jsp").forward(request, response);
    }
}
