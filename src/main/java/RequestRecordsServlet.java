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

@WebServlet("/RequestRecordsServlet")
public class RequestRecordsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "GSK&ydk1";
    private static final Logger logger = Logger.getLogger(RequestRecordsServlet.class.getName());

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
        // Retrieve form parameters
        String fullName = request.getParameter("fullName");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String email = request.getParameter("email");
        String phoneNumber = request.getParameter("phoneNumber");
        String recordType = request.getParameter("recordType");
        String requestReason = request.getParameter("requestReason");
        String preferredFormat = request.getParameter("preferredFormat");
        String deliveryMethod = request.getParameter("deliveryMethod");
        String notes = request.getParameter("notes");

        // Logging form data for debugging
        logger.info("fullName: " + fullName);
        logger.info("dateOfBirth: " + dateOfBirth);
        logger.info("email: " + email);
        logger.info("phoneNumber: " + phoneNumber);
        logger.info("recordType: " + recordType);
        logger.info("requestReason: " + requestReason);
        logger.info("preferredFormat: " + preferredFormat);
        logger.info("deliveryMethod: " + deliveryMethod);
        logger.info("notes: " + notes);

        // Validate required fields
        if (fullName == null || fullName.isEmpty() || 
            dateOfBirth == null || dateOfBirth.isEmpty() || 
            email == null || email.isEmpty() || 
            phoneNumber == null || phoneNumber.isEmpty() || 
            recordType == null || recordType.isEmpty() || 
            requestReason == null || requestReason.isEmpty() || 
            preferredFormat == null || preferredFormat.isEmpty() || 
            deliveryMethod == null || deliveryMethod.isEmpty() ||
            notes == null || notes.isEmpty()) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }
        
        // Validate input
        if (fullName == null || dateOfBirth == null || email==null || phoneNumber == null || recordType == null || requestReason == null || 
            preferredFormat == null || deliveryMethod == null || notes == null) {
            handleError(response, "Missing required fields. Please complete all fields.");
            return;
        }
        
       


        // Database operation
        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            if (insertRecordRequest(conn, fullName, dateOfBirth, email, phoneNumber, recordType, requestReason, preferredFormat, deliveryMethod, notes)) {
                sendSuccessResponse(response, fullName);
            } else {
                handleError(response, "Failed to submit the health records request. Please try again.");
            }
        } catch (SQLException e) {
            logger.log(Level.SEVERE, "Database error occurred", e);
            handleError(response, "There was an error connecting to the database. Please try again later.");
        }
    }

    private boolean insertRecordRequest(Connection conn, String fullName, String dateOfBirth, String email,
                                        String phoneNumber, String recordType, String requestReason,
                                        String preferredFormat, String deliveryMethod, String notes) throws SQLException {
        String sql = "INSERT INTO request_healthrecords (fullName, dateOfBirth, email, phoneNumber, recordType, requestReason, preferredFormat, deliveryMethod, notes) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, fullName);
            stmt.setString(2, dateOfBirth);
            stmt.setString(3, email);
            stmt.setString(4, phoneNumber);
            stmt.setString(5, recordType);
            stmt.setString(6, requestReason);
            stmt.setString(7, preferredFormat);
            stmt.setString(8, deliveryMethod);
            stmt.setString(9, notes);
            return stmt.executeUpdate() > 0;
        }
    }

    private void sendSuccessResponse(HttpServletResponse response, String fullName) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Health Record Request Submitted Successfully!</h3>");
            out.println("<p>Thank you, " + fullName + ". Your request is being processed.</p>");
            out.println("<p><a href='requestmyhealthrecords.jsp'>Back to Health Record Request Form</a></p>");
            out.println("</body></html>");
        }
    }

    private void handleError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("text/html");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html><body><h3>Error occurred!</h3>");
            out.println("<p>" + message + "</p>");
            out.println("<p><a href='requestmyhealthrecords.jsp'>Back to Health Record Request Form</a></p>");
            out.println("</body></html>");
        }
    }
}
