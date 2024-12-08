<!DOCTYPE html>
<html>
<head>
    <title>Sign Up - Student Health and Wellness</title>
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

        .signup-container {
            width: 350px; /* Width of the container */
            padding: 20px;
            border-radius: 10px; /* Rounded corners */
            background-color: rgba(0, 128, 0, 0.8); /* Semi-transparent green */
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.2); /* Optional shadow for better visibility */
            text-align: left; /* Center align text */
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

        p {
            color: #f0f0f0; /* Text color for the paragraph */
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
    <div class="signup-container">
        <h2>Sign Up</h2>
        <form action="AdminSignupServlet" method="post">
            <label for="username">Username:</label>
            <input type="text" id="username" name="username" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <button type="submit">Sign Up</button>
            <button type="button" class="google-signin" onclick="googleSignIn()">Sign in with Google</button>
        </form>
        <p>Already have an account? <a href="adminlogin.jsp">Login here</a></p>
    </div>
    <script>
    function googleSignIn() {
        const form = document.querySelector('form');
        const inputGoogleSignIn = document.createElement('input');
        inputGoogleSignIn.type = 'hidden';
        inputGoogleSignIn.name = 'googleSignIn';
        inputGoogleSignIn.value = 'true';
        form.appendChild(inputGoogleSignIn);
        
        // Redirect to Google OAuth
        window.location.href = 'https://accounts.google.com/o/oauth2/v2/auth?client_id=76928162414-heoq09m2hov6vgm552k4bjjlcc91hriq.apps.googleusercontent.com&redirect_uri=http://localhost:8081/Healthwell/login.jsp&response_type=code&scope=email%20profile';
    }
    </script>
</body>
</html>
