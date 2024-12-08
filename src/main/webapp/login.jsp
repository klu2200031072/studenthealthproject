<!DOCTYPE html>
<html>
<head>
    <title>Login - Student Health and Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/building.jpg'); /* Background image */
            background-size: cover;
            background-position: center;
            color: #f0f0f0; /* Light color for better visibility */
        }

        .login-container {
            width: 400px;
            margin: 100px auto;
            padding: 30px;
            background-color: rgba(0, 128, 0, 0.8); /* Semi-transparent green */
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2);
            text-align: center;
        }

        .login-container h2 {
            margin-bottom: 20px;
            color: #f0f0f0; /* Heading color */
            font-size: 28px;
        }

        .login-container label {
            display: block;
            text-align: left;
            margin-bottom: 5px;
            color: #f0f0f0; /* Label color */
        }

        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .login-container button {
            width: 100%;
            padding: 10px;
            background-color: #008000; /* Green button background */
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
        }

        .google-signin {
            width: 100%;
            padding: 10px;
            background-color: #db4437; /* Google red color */
            border: none;
            color: white;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            margin-top: 10px;
        }

        .login-container p {
            margin-top: 20px;
            color: #f0f0f0; /* Paragraph color */
            font-size: 16px;
        }

        .login-container a {
            color: #f0f0f0; /* Link color */
            text-decoration: none;
            font-weight: bold;
        }

        .login-container a:hover {
            color: #B0B0B0; /* Change link color on hover */
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Login</h2>
        <form action="LoginServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Login</button>
        </form>
        
        
        <p><a href="forgotpassword.jsp">Forgot Password?</a></p>
        <p>Don't have an account? <a href="signup.jsp">Sign up here</a></p>
        <p>Forgot password? <a href="forgotpassword.jsp">Change password here</a></p>
    </div>
</body>
</html>
