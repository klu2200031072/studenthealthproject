<%
    String username = request.getParameter("username");
    String email = request.getParameter("email");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup Success - Student Health and Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .success-container {
            text-align: center;
            padding: 20px;
            border-radius: 10px;
            background-color: #ffffff;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
        }

        h1 {
            color: #4CAF50;
        }

        p {
            font-size: 18px;
        }

        a {
            color: #4CAF50;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <h1>Signup Successful!</h1>
        <p>Welcome, <strong><%= (username != null && !username.isEmpty()) ? username : "User" %></strong>!</p>
        <p>Your email: <strong><%= (email != null && !email.isEmpty()) ? email : "Not provided" %></strong></p>
        <p><a href="login.jsp">Go to Login</a></p>
    </div>
</body>
</html>
