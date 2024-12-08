import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.WebServlet;

@WebServlet("/GoogleCallbackServlet")
public class GoogleCallbackServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String code = request.getParameter("code");
        
        // Exchange the code for an access token and fetch user info (Google API call here)

        // Example of parsed Google user info
        String googleUsername = "Hema garlapati"; // Retrieved from Google API
        String googleEmail = "example@gmail.com"; // Retrieved from Google API

        // Now save these credentials to your database
        // You can create a similar logic as in SignupServlet to check for existing users and insert the new user
    }
}
