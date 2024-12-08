<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eligibility and Access | Fit&Well</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        /* General styling for body */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
        }

        /* Navigation styling */
        header {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
        }
        header .nav-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        header .logo {
            font-size: 24px;
            font-weight: bold;
        }
        header nav ul {
            list-style-type: none;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        header nav ul li {
            display: inline;
        }
        header nav ul li a {
            color: white;
            text-decoration: none;
            font-weight: bold;
        }
        header nav ul li a:hover {
            text-decoration: underline;
        }

        /* Eligibility content styling */
        .eligibility-container {
            display: flex;
            justify-content: space-between;
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 20px;
        }

        .eligibility-image {
            width: 45%;
        }

        .eligibility-form {
            width: 45%;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .eligibility-form h2 {
            color: #4CAF50;
            margin-bottom: 20px;
        }

        .eligibility-form label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        .eligibility-form input[type="text"],
        .eligibility-form input[type="email"],
        .eligibility-form input[type="date"],
        .eligibility-form select {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .eligibility-form button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .eligibility-form button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <!-- Header with Navigation -->
    <header>
        <div class="nav-container">
            <div class="logo">Fit&Well</div>
            <nav>
                <ul>
                    <li><a href="home.jsp">Home</a></li>
                    <li><a href="event.jsp">Events</a></li>
                    <li><a href="unit.jsp">Units</a></li>
                    <li><a href="eligibility.jsp">Eligibility</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <div class="container">
            <p style="color: red; font-size: 32px; font-weight: bold;">Eligibility and Access</p>
        </div>

        <div class="eligibility-container">
            <!-- Image section -->
            <img src="images/eligibility1.jpg" alt="Eligibility Image" class="eligibility-image" />

            <!-- Eligibility Form -->
            <div class="eligibility-form">
                <h2>Apply for Eligibility</h2>
                <form action="ApplyEligibilityServlet" method="post">
                    <label for="fullname">Full Name:</label>
                    <input type="text" id="fullname" name="fullname" required>

                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" required>

                    <label for="dob">Date of Birth:</label>
                    <input type="date" id="dob" name="dob" required>

                    <label for="status">Status:</label>
                    <select id="status" name="status" required>
                        <option value="student">Student</option>
                        <option value="staff">Staff</option>
                    </select>

                    <button type="submit">Apply Now</button>
                </form>
            </div>
        </div>
    </main>
    <!-- Footer section -->
<footer style="background-color: #f5f5f5; padding: 10px; text-align: center;">
    <p style="color: #4CAF50;">&copy; 2024 Fit&Well. All rights reserved.</p>
</footer>
    
</body>
</html>