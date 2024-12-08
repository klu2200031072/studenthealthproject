import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/MyAllBookingsServlet")
public class MyAllBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("username");

        if (email == null) {
            response.sendRedirect("login.jsp?error=1"); // User not logged in
            return;
        }

        List<Booking> bookings = new ArrayList<>();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_health_wellness", "root", "GSK&ydk1")) {
                
                String query = "SELECT * FROM intramural_registrations WHERE email=?";
                PreparedStatement stmt = conn.prepareStatement(query);
                stmt.setString(1, email);
                
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setId(rs.getInt("id"));
                    booking.setName(rs.getString("name"));
                    booking.setEmail(rs.getString("email"));
                    booking.setPhone(rs.getString("phone"));
                    booking.setSport(rs.getString("sport"));  // Assuming 'sport' is a column in the table
                    booking.setStatus(rs.getString("status")); // Assuming 'status' is a column in the table
                    bookings.add(booking);
                }
                request.setAttribute("bookings", bookings);
                request.getRequestDispatcher("myallbookings.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // General error
        }
    }

    private static class Booking {
        private int id;
        private String name;
        private String email;
        private String phone;
        private String sport;  // New field
        private String status; // New field

        // Getters and setters
        public int getId() { return id; }
        public void setId(int id) { this.id = id; }
        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }
        public String getSport() { return sport; }
        public void setSport(String sport) { this.sport = sport; }
        public String getStatus() { return status; }
        public void setStatus(String status) { this.status = status; }
    }
}
