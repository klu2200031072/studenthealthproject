<!DOCTYPE html>
<html>
<head>
    <title>Forgot Password - Student Health and Wellness</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-image: url('images/building.jpg'); /* Background image */
            background-size: cover;
            background-position: center;
            color: #f0f0f0; /* Light color for better visibility */
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
        }

        .login-container {
            width: 350px; /* Increased width */
            padding: 20px;
            border-radius: 10px; /* Rounded corners */
            background-color: rgba(0, 128, 0, 0.8); /* Semi-transparent green */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Optional shadow for better visibility */
            text-align: center; /* Center align text */
        }

        h2 {
            color: #f0f0f0; /* Heading color */
            margin: 0 0 15px 0; /* Margin for spacing */
        }

        label {
            display: block; /* Block display for labels */
            margin-bottom: 10px; /* Space between label and input */
            color: #f0f0f0; /* Label color */
        }

        input {
            width: calc(100% - 20px); /* Full width minus padding */
            padding: 10px; /* Padding for a neater look */
            margin-top: 5px;
            border: 1px solid #ddd; /* Light border */
            border-radius: 5px; /* Rounded corners */
            font-size: 16px; /* Increased font size */
        }

        button {
            width: 100%; /* Make button full width */
            padding: 10px; /* Increased padding */
            background-color: #008000; /* Green background for the button */
            color: white; /* White text color for better contrast */
            border: none; /* Remove border */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
        }

        button:hover {
            background-color: #005700; /* Darker green on hover */
        }

        .error {
            color: red; /* Error message color */
            margin-top: 10px;
        }

        a {
            color: #f0f0f0; /* Link color */
            text-decoration: none; /* Remove underline */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h2>Forgot Password</h2>
        <form action="AdminSendOtpServlet" method="post">
            <label for="email">Enter your email:</label>
            <input type="email" id="email" name="email" required>
            <button type="submit">Send OTP</button>
        </form>

        <% if (request.getAttribute("errorMessage") != null) { %>
            <div class="error">
                <%= request.getAttribute("errorMessage") %>
            </div>
        <% } %>

        <p><a href="login.jsp">Back to Login</a></p>
    </div>
</body>
</html>
