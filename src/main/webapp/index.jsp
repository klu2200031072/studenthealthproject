<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Health and Wellness</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        html, body {
            height: 100%; /* Ensure the body takes full height */
            margin: 0; /* Remove default margin */
            display: flex;
            flex-direction: column; /* Arrange children in a column */
        }

        body {
            font-family: Arial, sans-serif;
            background-image: url('images/home.jpg');
            background-size: cover; /* This can be changed to 'contain' for a different effect */
            background-position: center;
            background-repeat: no-repeat;
        }

        .logo-container h2 {
            font-size: 18px; /* Decrease the font size for "Fit&Well" */
            margin: 0; /* Remove any default margin */
        }

        .user-info {
            font-size: 19px; /* Decrease the font size for the login status */
            margin-right: 50px; /* Space between the user info and the nav items */
            color: #333; /* Default color for the text */
        }

        header {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
            margin-bottom: 0;
            background-color: rgba(255, 255, 255, 0.8);
            padding: 10px 0;
        }

        .header-container {
            width: 100%;
        }

        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 20px;
        }

        .top-nav {
            width: 100%;
            text-align: right;
        }

        .top-nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: flex-end;
            margin: 0;
        }

        .top-nav li {
            margin: 0 10px;
        }

        .sub-header {
            width: 100%;
            padding: 10px 0;
            background-color: #4CAF50;
            text-align: center;
        }

        .sub-header h1 {
            font-size: 24px;
            color: white;
            margin: 0;
        }

        .sub-nav {
            padding: 5px 0;
        }

        .sub-nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center;
        }

        .sub-nav li {
            margin: 0 10px;
        }

        main {
            flex-grow: 1; /* Allow main to grow and fill the available space */
            padding-bottom: 500px; /* Increase space between background image and footer */
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
        <nav class="top-nav">
            <ul>
                <li><a href="#">Unit Directory</a></li>
                <li><a href="#">Event Calendar</a></li>
                <li><a href="#">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
                <li><a href="#">Rec Portal</a></li>
                <li><a href="#" class="cyclone-support">Cyclone Support</a></li>
            </ul>
        </nav>
    </header>

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
                    <a href="venues.jsp">Venues</a>
                    
                </div>
            </li>
            <li id="medical-services" class="dropdown">
                <a href="#">Medical Services</a>
                <div id="medical-dropdown-content" class="dropdown-content">
                    <a href="illnessinjury.jsp">Illness and Injury Care</a>
                    <a href="preventativecare.jsp">Preventative Care</a>
                    <a href="physicaltherapy.jsp">Physical Therapy</a>
                    <a href="insurance.jsp">Fees, Insurance, and Billing</a>
                    <a href="reproductivehealth.jsp">Sexual & Reproductive Health</a>
                    <a href="pharmacy.jsp">Pharmacy</a>
                    <a href="policiesandforms.jsp">Policies & Forms</a>
                    <a href="requestmyhealthrecords.jsp">Request My Health Records</a>
                    <a href="makeanappointment.jsp">Make an Appointment</a>
                    
                </div>
            </li>
            <li id="mental-health" class="dropdown">
                <a href="#">Mental Health</a>
                <div id="mental-health-dropdown-content" class="dropdown-content">
                    <a href="urgentneeds.jsp">Urgent Needs (In Crisis)</a>
                    <a href="counseling.jsp">Counseling</a>
                    <a href="medication.jsp">Mental Health Medication</a>
                    <a href="meditation.jsp">Meditation, Breathing, and Sleep</a>
                    <a href="lifestyle.jsp">Wellbeing and Lifestyle</a>
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

    <main>
        <!-- Main content can go here -->
    </main>

    <footer>
        <div class="footer-intro">
            <h2>Fit&Well</h2>
            <p>Elevate your well-being with every step you take, Commit to a journey of health and fitness, Where every workout is a stride toward a stronger you. Nourish your body with balanced nutrition and mindful habits, And empower your mind with resilience and positivity. Celebrate the small victories and embrace the challenges, Knowing each one brings you closer to your goals. Stay motivated and inspired, Surround yourself with a supportive community, And let every day be an opportunity for growth. Together, we build a foundation of lasting wellness, Balancing strength, flexibility, and mental clarity. Invest in yourself, and watch your potential unfold, As we guide you through every phase of your fitness journey. Your path to a healthier, happier life starts here.</p>
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
