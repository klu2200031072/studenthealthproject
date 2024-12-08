import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.WebServlet;

@WebServlet("/MyBookingsServlet")
public class MyBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        System.out.println("Email received: " + email); // Debug line

        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h2>Your Bookings</h2><table border='1'><tr><th>Reservation ID</th><th>Name</th><th>Facility</th><th>Reservation Date</th><th>Reservation Time</th><th>Status</th></tr>");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM facility_reservations2 WHERE email = ?")) {
                stmt.setString(1, email);
                ResultSet rs = stmt.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("<tr><td colspan='6'>No reservations found.</td></tr>");
                } else {
                    while (rs.next()) {
                        int reservationId = rs.getInt("reservation_id");
                        String name = rs.getString("name");
                        String facility = rs.getString("facility");
                        Date reservationDate = rs.getDate("reservation_date");
                        Time reservationTime = rs.getTime("reservation_time");
                        String status = rs.getString("status");

                        out.println("<tr><td>" + reservationId + "</td><td>" + name + "</td><td>" + facility + "</td><td>" + reservationDate + "</td><td>" + reservationTime + "</td><td>" + status + "</td></tr>");
                    }
                }
            } catch (SQLException e) {
                out.println("<tr><td colspan='6'>Error fetching bookings: " + e.getMessage() + "</td></tr>");
                e.printStackTrace(); // Print stack trace for debugging
            }

            out.println("</table><p><a href='facilities.jsp'>Back to Reservation Form</a></p></body></html>");
        }
    }
}
