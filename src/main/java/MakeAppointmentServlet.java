import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/MakeAppointmentServlet")
public class MakeAppointmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(MakeAppointmentServlet.class.getName());

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
    	String fullName = request.getParameter("fullName");
    	String email = request.getParameter("email");
    	String phone = request.getParameter("phone");
    	String serviceType = request.getParameter("serviceType");
    	String appointmentDate = request.getParameter("appointmentDate");
    	String appointmentTime = request.getParameter("appointmentTime");
    	String details = request.getParameter("details");

    	// Debug each parameter to confirm their values
    	logger.info("fullName: " + fullName);
    	logger.info("email: " + email);
    	logger.info("phone: " + phone);
    	logger.info("serviceType: " + serviceType);
    	logger.info("appointmentDate: " + appointmentDate);
    	logger.info("appointmentTime: " + appointmentTime);
    	logger.info("details: " + details);

    	// Check for null or empty values
    	if (fullName == null || fullName.isEmpty() || 
    	    email == null || email.isEmpty() || 
    	    phone == null || phone.isEmpty() || 
    	    serviceType == null || serviceType.isEmpty() || 
    	    appointmentDate == null || appointmentDate.isEmpty() || 
    	    appointmentTime == null || appointmentTime.isEmpty() || 
    	    details == null || details.isEmpty()) {
    	    handleError(response, "Missing required fields. Please complete all fields.");
    	    return;
    	}



        // Validate input
        if (fullName == null || email == null || phone == null || serviceType == null || appointmentDate == null || 
            appointmentTime == null || details == null) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if (insertAppointment(conn, fullName, email, phone, serviceType , appointmentDate, appointmentTime, details)) {
                sendSuccessResponse(response, fullName);
            } else {
                handleError(response, "Failed to book the appointment. Please try again.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private boolean insertAppointment(Connection conn, String fullName, String email, String phone,
    		
                                     String serviceType, String appointmentDate, String appointmentTime, String details) throws SQLException {
        String sql = "INSERT INTO general_appointments (fullName, email, phone, serviceType, appointmentDate, appointmentTime, details) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
        	 stmt.setString(1, fullName);
             stmt.setString(2, email);
             stmt.setString(3, phone);
             stmt.setString(4, serviceType);
             stmt.setString(5, appointmentDate);
             stmt.setString(6, appointmentTime);
             stmt.setString(7, details);

            return stmt.executeUpdate() > 0;
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String fullName) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Appointment booked successfully!</h3>");
            out.println("<p>Thank you, " + fullName + ". Your appointment has been scheduled.</p>");
            out.println("<p><a href='makeanappointment.jsp'>Back to Make an appointment Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='makeanappointment.jsp'>Back to Make an appointment Form</a></p>");
            out.println("</body></html>");
        }
    }
}
