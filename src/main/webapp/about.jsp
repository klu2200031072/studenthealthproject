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
            background-color: #4CAF50;
        }
        
        .sub-header h1 {
            font-size: 36px; /* Adjust the font size as needed */
            color: white; /* Change text color to white */
            margin: 0; /* Remove default margin */
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
                <li><a href="#">Unit Directory</a></li>
                <li><a href="#">Event Calendar</a></li>
                <li><a href="#">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
                <li><a href="#">Rec Portal</a></li>
                <li><a href="#" class="cyclone-support">Cyclone Support</a></li>
            </ul>
        </div>

        <div class="sub-header">
            <h1>Student Health and Wellness</h1>
        </div>

        <nav class="sub-nav">
            <ul>
                
                <li><a href="about.jsp">About</a></li>
                <li id="recreation" class="dropdown">
                    <a href="#">Recreation</a>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="facilities.jsp">Facilities</a>
                        <a href="fitness.jsp">Fitness</a>
                        <a href="intramural.jsp">Intramural Sports</a>
                        <a href="sportclub.jsp">Sport Clubs</a>
                        <a href="youthcamp.jsp">Youth Camps</a>
                        
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
                        <a href="#">Meditation, Breathing, and Sleep</a>
                        <a href="#">Wellbeing and Lifestyle</a>
                    </div>
                </li>
                <li id="support-programs" class="dropdown">
                    <a href="#">Support Programs</a>
                    <div id="support-programs-dropdown-content" class="dropdown-content">
                        <a href="substance-use-support.jsp">Substance Use Support</a>
                        <a href="nutrition.jsp">Nutrition & Body Image</a>
                        <a href="food.jsp">Food Security Support</a>
                        <a href="training.jsp">Training Opportunities</a>
                        <a href="suicide.jsp">Suicide Prevention</a>
                        <a href="violence.jsp">Violence Prevention</a>
                    </div>
                </li>
            </ul>
        </nav>
    </header>

    <main>
        <div class="banner">
            <img src="images/home.jpg" alt="Fit&Well App Banner" />
        </div>

        <section class="info-section">
            <h3>About the Fit&Well App</h3>
            <p>
                The Fit&Well app is your comprehensive health and wellness companion designed to support you throughout your academic journey. With a focus on holistic well-being, the app offers various features to help you manage your health effectively.
            </p>
            <h4>Key Features:</h4>
            <ul>
                <li><strong>Personalized Health Assessments:</strong> Complete assessments to receive tailored health recommendations.</li>
                <li><strong>Appointment Scheduling:</strong> Easily book appointments with medical and wellness professionals directly through the app.</li>
                <li><strong>Wellness Resources:</strong> Access articles, videos, and tips on physical fitness, mental health, and nutrition.</li>
                <li><strong>Emergency Assistance:</strong> Find immediate support options for urgent needs and crisis situations.</li>
                <li><strong>Community Support:</strong> Connect with peers and support groups to share experiences and advice.</li>
            </ul>
            <h4>Benefits of Using the Fit&Well App:</h4>
            <p>
                By utilizing the Fit&Well app, you can enhance your overall wellness and academic performance. The app enables you to:
            </p>
            <ul>
                <li>Track your health and wellness journey with ease.</li>
                <li>Stay informed about health events and workshops.</li>
                <li>Receive reminders for appointments and health check-ups.</li>
                <li>Access mental health resources for stress management and emotional support.</li>
            </ul>
            <p>
                We believe that a healthy student is a successful student, and the Fit&Well app is designed to empower you on your path to health and well-being.
            </p>
        </section>
    </main>

   <footer>
        <div class="footer-intro">
            <h2>Fit&Well</h2>
            <p>Elevate your well-being with every step you take,
Commit to a journey of health and fitness,
Where every workout is a stride toward a stronger you.
Nourish your body with balanced nutrition and mindful habits,
And empower your mind with resilience and positivity.
Celebrate the small victories and embrace the challenges,
Knowing each one brings you closer to your goals.
Stay motivated and inspired,
Surround yourself with a supportive community,
And let every day be an opportunity for growth.
Together, we build a foundation of lasting wellness,
Balancing strength, flexibility, and mental clarity.
Invest in yourself, and watch your potential unfold,
As we guide you through every phase of your fitness journey.
Your path to a healthier, happier life starts here.</p>
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