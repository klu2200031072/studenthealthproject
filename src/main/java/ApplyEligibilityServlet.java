import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApplyEligibilityServlet")
public class ApplyEligibilityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String status = request.getParameter("status");

        // Process the data (e.g., save to database or perform some action)
        
        // Example: Sending a simple response back
        response.setContentType("text/html");
        response.getWriter().println("Application received for: " + fullName + " (" + email + ")");
    }
}
