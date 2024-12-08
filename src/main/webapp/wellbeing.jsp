<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wellbeing Life Style | Fit&Well</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        /* General styling for the header and user info */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        header {
            display: flex;
            flex-direction: column;
            position: relative;
        }
        .header-container {
            background: #f5f5f5; /* Light grey background for header */
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }
        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .logo {
            margin-right: 10px;
        }
        
        .user-info {
            float: right;
            margin: 20px;
            font-size: 16px;
            color: green; /* Change text color to green */
        }
        
        .sub-header {
            text-align: center;
            padding: 10px;
        }
        .sub-header h1 {
            font-size: 36px; /* Adjust the font size as needed */
            color: green; /* Change text color to green */
            margin: 0; /* Remove default margin if needed */
        }
        
        .dashboard-nav {
            display: flex;
            justify-content: flex-end;
            padding: 10px 20px;
            background-color: #ddd; /* Light grey background for dashboard nav */
            border-bottom: 1px solid #ccc;
        }
        .dashboard-nav ul {
            display: flex;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .dashboard-nav ul li {
            margin: 0 10px;
        }
        .dashboard-nav ul li a {
            text-decoration: none;
            color: #333;
            padding: 10px;
        }
        .dashboard-nav ul li a:hover {
            background-color: #bbb;
            border-radius: 4px;
        }
        .sub-nav {
            background-color: #eee; /* Light grey background for sub-nav */
        }
        .sub-nav ul {
            display: flex;
            justify-content: center;
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .sub-nav ul li {
            margin: 0 10px;
        }
        .sub-nav ul li a {
            text-decoration: none;
            color: #333;
            padding: 10px;
        }
        .sub-nav ul li a:hover {
            background-color: #ddd;
            border-radius: 4px;
        }
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #fff;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }
        .dropdown-content a:hover {
            background-color: #ddd;
        }
        .dropdown:hover .dropdown-content {
            display: block;
        }
        footer {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: #4CAF50; /* Green background color */
            color: white; /* White text color for contrast */
            border-top: 1px solid #ddd;
        }
        .footer-intro,
        .footer-contact {
            flex: 1;
            padding: 0 20px;
        }
        .footer-intro {
            max-width: 50%;
        }
        .footer-contact {
            max-width: 50%;
        }
        .footer-intro p {
            font-size: 16px; /* Adjust font size as needed */
            line-height: 1.5; /* Improve readability */
        }
        .footer-contact p {
            margin: 10px 0;
        }
        .footer-contact a {
            color: #fff; /* White links for better contrast */
            text-decoration: none;
        }
        .footer-contact a:hover {
            text-decoration: underline;
        }
        @media (max-width: 768px) {
            footer {
                flex-direction: column;
                align-items: flex-start;
            }
            .footer-intro,
            .footer-contact {
                max-width: 100%;
                padding: 10px 0;
            }
        }

        /* Image and text styling */
        .main-content {
            display: flex; /* Use flexbox for layout */
            flex-direction: row; /* Arrange items in a row */
            align-items: flex-start; /* Align items to the top */
            margin: 20px; /* Add some margin around the main content */
        }

        .content-container {
            display: flex; /* Make the container a flexbox */
            flex-direction: row; /* Arrange items in a row */
            flex-wrap: wrap; /* Allow wrapping for responsive design */
            gap: 20px; /* Add space between the image and text */
        }

        .header-image {
            max-width: 50%; /* Limit the image width to 50% */
            height: auto; /* Maintain aspect ratio */
        }

        .text-content {
            max-width: 50%; /* Limit text width to 50% */
        }
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="header-flex">
                <div class="logo-container">
                    <img src="images/university-logo.png" alt="University Logo" class="logo" style="height: 60px;" />
                    <h2>Fit&Well</h2>
                </div>
                <div class="user-info">
                    <%
                        // Retrieve the username from the session
                        String username = (String) session.getAttribute("username");
                        if (username != null) {
                            out.print("Logged in as: <span style='color: green;'>" + username + "</span>");
                        } else {
                            out.print("Not logged in");
                        }
                    %>
                </div>
            </div>
        </div>

        <!-- Dashboard Navigation -->
        <div class="dashboard-nav">
            <ul>
                <li><a href="unit.jsp">Unit Directory</a></li>
                <li><a href="event.jsp">Event Calendar</a></li>
                <li><a href="eligibility.jsp">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
                <li><a href="#">Rec Portal</a></li>
                <li><a href="#" class="cyclone-support">Cyclone Support</a></li>
            </ul>
        </div>

        <div class="sub-header">
            <h1>Wellbeing and Lifestyle</h1>
        </div>

        <nav class="sub-nav">
            <ul>
                <li><a href="#">About</a></li>
                <li id="recreation" class="dropdown">
                    <a href="#">Recreation</a>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="facilities.jsp">Facilities</a>
                        <a href="#">Fitness</a>
                        <a href="#">Intramural Sports</a>
                        <a href="#">Adventure</a>
                        <a href="#">Sport Clubs</a>
                        <a href="#">Gaming & Esports</a>
                        <a href="#">Membership</a>
                        <a href="#">Youth Camps</a>
                        <a href="#">Swim Lessons</a>
                        <a href="#">Employment</a>
                    </div>
                </li>
                <li id="medical-services" class="dropdown">
                    <a href="#">Medical Services</a>
                    <div id="medical-dropdown-content" class="dropdown-content">
                        <a href="#">Illness and Injury Care</a>
                        <a href="#">Preventative Care</a>
                        <a href="#">Physical Therapy</a>
                        <a href="#">Fees, Insurance, and Billing</a>
                        <a href="#">Sexual & Reproductive Health</a>
                        <a href="#">Pharmacy</a>
                        <a href="#">Policies & Forms</a>
                        <a href="#">Request My Health Records</a>
                        <a href="#">Make an Appointment</a>
                    </div>
                </li>
                <li id="mental-health" class="dropdown">
                    <a href="#">Mental Health</a>
                    <div id="mental-health-dropdown-content" class="dropdown-content">
                        <a href="#">Urgent Needs (In Crisis)</a>
                        <a href="#">Counseling</a>
                        <a href="#">Mental Health Medication</a>
                        <a href="meditation.jsp">Meditation, Breathing, and Sleep</a>
                        <a href="wellbeing.jsp">Wellbeing and Lifestyle</a>
                    </div>
                </li>
            </ul>
        </nav>
    </header>

    <div class="main-content">
        <div class="content-container">
            <img src="images/lifestyle.jpg" alt="Wellbeing and Lifestyle" class="header-image" />
            <div class="text-content">
                <h2>Importance of Wellbeing and Lifestyle</h2>
                <p>Wellbeing and lifestyle choices play a crucial role in a student’s overall health and academic performance. The Fit&Well app emphasizes the importance of holistic wellness through fitness, nutrition, and mental health support.</p>
                <p>Engaging in regular physical activity, maintaining a balanced diet, and focusing on mental wellness can significantly improve concentration, reduce stress, and enhance overall quality of life. The Fit&Well app provides resources and support to help students make informed choices that promote their wellbeing.</p>
                <h2>Explore Your Options</h2>
                <p>Whether you are looking to improve your fitness, enhance your nutritional habits, or seek mental health resources, Fit&Well offers a variety of programs and services tailored to meet your needs.</p>
                <p>Join our community of students committed to fostering a healthier lifestyle!</p>
            </div>
        </div>
    </div>

    <footer>
        <div class="footer-intro">
            <h3>Fit&Well Overview</h3>
            <p>Fit&Well is dedicated to enhancing the wellbeing of students through various services focused on fitness, nutrition, and mental health. Our platform connects students with resources that support their health and lifestyle choices.</p>
        </div>
        <div class="footer-contact">
            <h3>Contact Us</h3>
            <p>Email: <a href="mailto:info@fitandwell.com">info@fitandwell.com</a></p>
            <p>Phone: <a href="tel:+1234567890">+1 234 567 890</a></p>
            <p>Address: 123 Wellness St, Healthy City, ST 12345</p>
        </div>
    </footer>
</body>
</html>
