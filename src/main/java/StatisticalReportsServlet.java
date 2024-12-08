import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/StatisticalReportsServlet")
public class StatisticalReportsServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            // Retrieve data from the database
            int totalBookings = 0;
            int acceptedBookings = 0;
            int rejectedBookings = 0;
            int pendingBookings = 0;

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                // Total bookings
                String sql = "SELECT COUNT(*) AS total FROM facility_reservations2";
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        totalBookings = rs.getInt("total");
                    }
                }

                // Accepted bookings
                sql = "SELECT COUNT(*) AS accepted FROM facility_reservations2 WHERE status = 'Accepted'";
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        acceptedBookings = rs.getInt("accepted");
                    }
                }

                // Rejected bookings
                sql = "SELECT COUNT(*) AS rejected FROM facility_reservations2 WHERE status = 'Rejected'";
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        rejectedBookings = rs.getInt("rejected");
                    }
                }

                // Pending bookings
                sql = "SELECT COUNT(*) AS pending FROM facility_reservations2 WHERE status = 'Pending'";
                try (PreparedStatement stmt = conn.prepareStatement(sql);
                     ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        pendingBookings = rs.getInt("pending");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                // Handle exception
            }

            // Generate HTML with Chart.js
            out.println("<html><head>");
            out.println("<title>Booking Statistics</title>");
            out.println("<script src='https://cdn.jsdelivr.net/npm/chart.js'></script>");
            out.println("</head><body>");
            out.println("<h2>Booking Statistics</h2>");
            out.println("<canvas id='bookingChart' width='400' height='200'></canvas>");
            out.println("<script>");
            out.println("const ctx = document.getElementById('bookingChart').getContext('2d');");
            out.println("const bookingChart = new Chart(ctx, {");
            out.println("    type: 'bar',");
            out.println("    data: {");
            out.println("        labels: ['Total Bookings', 'Accepted Bookings', 'Rejected Bookings', 'Pending Bookings'],");

            out.println("        datasets: [{");
            out.println("            label: 'Bookings',");
            out.println("            data: [" + totalBookings + ", " + acceptedBookings + ", " + rejectedBookings + ", " + pendingBookings + "],");
            out.println("            backgroundColor: ['rgba(75, 192, 192, 0.2)', 'rgba(54, 162, 235, 0.2)', 'rgba(255, 99, 132, 0.2)', 'rgba(255, 206, 86, 0.2)'],");
            out.println("            borderColor: ['rgba(75, 192, 192, 1)', 'rgba(54, 162, 235, 1)', 'rgba(255, 99, 132, 1)', 'rgba(255, 206, 86, 1)'],");
            out.println("            borderWidth: 1");
            out.println("        }]");
            out.println("    },");
            out.println("    options: {");
            out.println("        scales: {");
            out.println("            y: {");
            out.println("                beginAtZero: true");
            out.println("            }");
            out.println("        }");
            out.println("    }");
            out.println("});");
            out.println("</script>");
            out.println("<p><a href='admin_dashboard.jsp'>Back to Admin Dashboard</a></p>");
            out.println("</body></html>");
        }
    }
}
