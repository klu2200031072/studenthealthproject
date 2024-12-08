


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/SendOtpServlet")
public class SendOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        int otp = new Random().nextInt(999999); // Generate a random OTP

        // Store OTP in session for later verification
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("email", email); // Store email for password reset

        // Set up email properties
        String host = "smtp.gmail.com";
        String user = "2200031072cseh@gmail.com"; // Your email
        String password = "rqim djmv bzmo sysq"; // Your app password

        Properties props = new Properties();
        props.put("mail.smtp.host", host);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(user, password);
            }
        });

        try {
            MimeMessage message = new MimeMessage(mailSession);
            message.setFrom(new InternetAddress(user));
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
            message.setSubject("Your OTP Code");
            message.setText("Your OTP code is: " + otp);

            Transport.send(message);
            response.sendRedirect("verify_otp.jsp"); // Redirect to OTP verification page
        } catch (MessagingException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error sending OTP. Please try again."); // Set error message
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response); // Forward to the forgot password page with error
        }
    }
}

