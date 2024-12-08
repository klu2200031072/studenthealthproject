<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food | Fit&Well</title>
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
            background: #f5f5f5;
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
            color: green;
        }
        .sub-header {
            text-align: center;
            padding: 10px;
        }
        .sub-header h1 {
            font-size: 36px;
            color: green;
            margin: 0;
        }
        .dashboard-nav {
            display: flex;
            justify-content: flex-end;
            padding: 10px 20px;
            background-color: #ddd;
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
            background-color: #eee;
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
            background-color: #4CAF50;
            color: white;
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
            font-size: 16px;
            line-height: 1.5;
        }
        .footer-contact p {
            margin: 10px 0;
        }
        .footer-contact a {
            color: #fff;
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

        /* Styling for the main content */
        .content {
            padding: 20px;
        }

        /* Flexbox for images and text */
        .wellness-content {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 20px;
        }
        .wellness-content img {
            max-width: 40%;
            height: auto;
            border-radius: 10px;
        }
        .wellness-text {
            max-width: 50%;
        }
        .wellness-text h2,
        .wellness-text h3 {
            color: #4CAF50;
        }
        .wellness-text p {
            font-size: 18px;
            line-height: 1.6;
        }
        @media (max-width: 768px) {
            .wellness-content {
                flex-direction: column;
            }
            .wellness-text,
            .wellness-content img {
                max-width: 100%;
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
                <li><a href="unit.jsp">Unit Directory</a></li>
                <li><a href="event.jsp">Event Calendar</a></li>
                <li><a href="eligibility.jsp">Eligibility</a></li>
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
                <li><a href="#">About</a></li>
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

    <div class="content">
        <div class="wellness-content">
            <!-- Images for Meditation, Breathing, and Sleep -->
            <img src="images/food.jpg" alt="food" class="food-image" />
            
            <!-- Section on Meditation, Breathing, and Sleep -->
            <section class="wellness-text">
            <h2>Food Support and Nutrition</h2>
<p>Proper nutrition is essential for maintaining overall health and well-being. Access to healthy food options can help students improve their focus, boost their mood, and support their academic performance. Our Fit&Well program offers various resources to assist students in making informed food choices and accessing nutritious meals.</p>

<h3>Nutritional Guidance</h3>
<p>Our nutrition experts provide personalized advice to help students understand their dietary needs. Join our sessions to learn about balanced diets, portion sizes, and the importance of incorporating a variety of food groups into your meals.</p>

<h3>Food Access Programs</h3>
<p>We offer resources to help students access healthy food options, including food pantries and meal programs. Our initiatives aim to ensure that all students have the support they need to maintain a nutritious diet.</p>

<h3>Cooking Workshops</h3>
<p>Learn practical cooking skills through our workshops designed for all levels. Discover simple, healthy recipes that can be prepared quickly and easily, empowering you to make healthier choices at home.</p>


            
            
            
            
            
            
            
            
       
            
            </section>
        </div>
    </div>

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