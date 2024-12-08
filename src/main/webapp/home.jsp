<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fit&Well</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        header {
            display: flex;
            flex-direction: column;
            background-color: #f5f5f5;
            border-bottom: 1px solid #ddd;
        }
        .header-container {
            padding: 5px 0;
        }
        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 10px;
        }
        .logo-container {
            display: flex;
            align-items: center;
        }
        .logo {
            margin-right: 10px;
            height: 50px; /* Reduced size */
        }
        .user-info {
            float: right;
            margin: 10px;
            font-size: 14px;
            color: green;
        }
        .sub-header h1 {
            font-size: 28px; /* Adjusted font size */
            color: green;
            margin: 0;
        }
        .dashboard-nav {
            display: flex;
            justify-content: flex-end;
            padding: 5px 10px;
            background-color: #ddd;
        }
        .dashboard-nav ul {
            display: flex;
            margin: 0;
            padding: 0;
            list-style: none;
        }
        .dashboard-nav ul li {
            margin: 0 8px;
        }
        .dashboard-nav ul li a {
            text-decoration: none;
            color: #333;
            padding: 8px;
        }
        .dashboard-nav ul li a:hover {
            background-color: #bbb;
            border-radius: 4px;
        }
        footer {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            background-color: #4CAF50;
            color: white;
            border-top: 1px solid #ddd;
            font-size: 14px; /* Reduced font size */
        }
        .footer-intro,
        .footer-contact {
            flex: 1;
            padding: 0 10px;
        }
        .footer-intro p {
            font-size: 14px; /* Reduced font size */
            line-height: 1.4;
        }
        .footer-contact p {
            margin: 8px 0;
        }
        .footer-contact a {
            color: #fff;
            text-decoration: none;
        }
        .footer-contact a:hover {
            text-decoration: underline;
        }
        .banner {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 20px;
        }
        .banner img {
            max-width: 300px; /* Reduced image size */
            border-radius: 8px;
        }
        .welcome-section {
            flex: 1;
            padding-left: 20px;
        }
        .welcome-section h3 {
            font-size: 24px;
            color: green;
        }
        .welcome-section p {
            font-size: 14px;
            line-height: 1.6;
        }
        .welcome-section ul {
            padding-left: 20px;
        }
        @media (max-width: 768px) {
            .banner {
                flex-direction: column;
            }
            .welcome-section {
                padding-left: 0;
                margin-top: 20px;
            }
            footer {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <header>
        <div class="header-container">
            <div class="header-flex">
                <div class="logo-container">
                    <img src="images/university-logo.png" alt="University Logo" class="logo" />
                    <h2>Fit&Well</h2>
                </div>
                <div class="user-info">
                    <%
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

        <div class="dashboard-nav">
            <ul>
                <li><a href="unit.jsp">Unit Directory</a></li>
                <li><a href="event.jsp">Event Calendar</a></li>
                <li><a href="eligibility.jsp">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
                <li><a href="#">Rec Portal</a></li>
                <li><a href="#" class="cyclone-support">Student Health Support</a></li>
            </ul>
        </div>

        <div class="sub-header">
            <h1>Student Health and Wellness</h1>
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
                        <a href="youthcamp.jsp">Youth Camps</a>
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
                <li id="support-programs" class="dropdown">
                    <a href="#">Support Programs</a>
                    <div id="support-programs-dropdown-content" class="dropdown-content">
                        <a href="substance-use-support.jsp">Substance Use Support</a>
                        <a href="nutrition.jsp">Nutrition & Body Image</a>
                        <a href="food.jsp">Food Security Support</a>
                        <a href="#">Training Opportunities</a>
                        <a href="#">Get Involved</a>
                        <a href="#">Wellbeing Coaching</a>
                        <a href="#">Suicide Prevention</a>
                        <a href="#">Violence Prevention</a>
                    </div>
                </li>
            </ul>
        </nav>
  
        </div>
    </header>

    <main>
        <div class="banner">
            <img src="images/home.jpg" alt="Home Image" />
            <section class="welcome-section">
                <h3>Welcome to Fit&Well</h3>
                <p>
                    Welcome to Fit&Well! Our mission is to support your journey towards achieving your best physical and mental health. We are dedicated to providing you with top-notch medical, mental health, and wellness services throughout your time at our institution and beyond. Our comprehensive approach includes:
                </p>
                <ul>
                    <li><strong>Medical Care:</strong> Access to quality healthcare services designed to meet your needs.</li>
                    <li><strong>Mental Health Support:</strong> Counseling and resources to help you manage stress and maintain a balanced lifestyle.</li>
                    <li><strong>Wellness Resources:</strong> Educational materials and guidance on maintaining a healthy and active lifestyle.</li>
                </ul>
                <p>
                    We believe that a healthy student is a successful student. Our services are available to all registered users who are enrolled with our app, ensuring you have the resources you need to thrive.
                </p>
            </section>
        </div>
    </main>

    <footer>
        <div class="footer-intro">
            <h2>Fit&Well</h2>
            <p>Elevate your well-being with every step you take...</p>
        </div>
        <div class="footer-contact">
            <h3>Tell us about your wellness goals:</h3>
            <p><strong>Email:</strong> <a href="mailto:hello@fitandwellapp.com">hello@fitandwellapp.com</a></p>
            <p><strong>Phone:</strong> <a href="tel:+6598735984">(+65) 98735984</a></p>
            <p><strong>Address:</strong><br>
            1 Paya Lebar Link<br>
            #04-01, Paya Lebar Quarter<br>
            Singapore, 408533</p>
        </div>
    </footer>

    <footer class="footer-bottom">
        <p>&copy; Fit&Well, 2024</p>
    </footer>
</body>
</html>