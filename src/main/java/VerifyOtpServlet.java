import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOtpServlet")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int enteredOtp = Integer.parseInt(request.getParameter("otp"));
        HttpSession session = request.getSession();
        int generatedOtp = (Integer) session.getAttribute("otp");

        if (enteredOtp == generatedOtp) {
            response.sendRedirect("reset_password.jsp"); // Redirect to password reset page
        } else {
            response.sendRedirect("verify_otp.jsp?error=1"); // Redirect back with error
        }
    }
}
