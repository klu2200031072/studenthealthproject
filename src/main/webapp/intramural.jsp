<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intramural Sports Schedule & Registration | Fit&Well</title>
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
            background-color:#4CAF50;
            
        }
        
        .sub-header h1 {
            font-size: 36px; /* Adjust the font size as needed */
            color: white; /* Change text color to green */
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

        /* Image styling */
        .header-image {
            width: 100%;
            height: auto;
            margin-top: 20px;
        }
        
        /* Facility reservation form styling */
        .reservation-form {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .reservation-form h1 {
            margin-top: 0;
            color: green; /* Change text color to green */
        }
        .reservation-form label {
            display: block;
            margin-bottom: 10px;
        }
        .reservation-form input, .reservation-form select, .reservation-form textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .reservation-form button {
            background-color: green; /* Green background for button */
            color: white; /* White text for button */
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .reservation-form button:hover {
            background-color: #45a049; /* Darker green on hover */
        }
        /* Sports Schedule Styling */
        .sport-list {
            list-style-type: none;
            padding: 0;
        }
        .sport-list li {
            margin-bottom: 10px;
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
                <li><a href="#">About</a></li>
                <li id="recreation" class="dropdown">
                    <a href="#">Recreation</a>
                    <div id="dropdown-content" class="dropdown-content">
                        <a href="facilities.jsp">Facilities</a>
                        <a href="#">Fitness</a>
                        <a href="intramural.jsp">Intramural Sports</a>
                        <a href="#">Sport Clubs</a>
                        <a href="#">Youth Camps</a>
                        
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

        <!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Intramural Sports Schedule & Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }
        table {
            margin: 0 auto;
            border-collapse: collapse;
            width: 80%;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f4f4f4;
        }
        h1, h2 {
            color: #333;
        }
    </style>
</head>
<body>
    <main>
        <h1>Intramural Sports Schedule & Registration</h1>
        
        <section>
            <h2>Fall 2024</h2>
            <p>Below is the schedule for Fall 2024 intramural sports. For detailed information or to register, please use the link provided.</p>
            <table>
                <thead>
                    <tr>
                        <th>Sport</th>
                        <th>Season Start/End Date</th>
                        <th>Registration Opens</th>
                        <th>Registration Closes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Football Weekly Pick’ems (Open)</td>
                        <td>9/2-12/3</td>
                        <td>8/15/2024</td>
                        <td>12/3/2024</td>
                    </tr>
                    <tr>
                        <td>Curling (Open) - $25/team</td>
                        <td>9/22-11/14</td>
                        <td>9/2/2024</td>
                        <td>9/15/2024</td>
                    </tr>
                    <tr>
                        <td>Survivor Fantasy (Open)</td>
                        <td>9/18-12/18</td>
                        <td>9/4/2024</td>
                        <td>9/18/2024</td>
                    </tr>
                    <tr>
                        <td>WIN Night – Indoor Volleyball</td>
                        <td>10/1/2024</td>
                        <td>–</td>
                        <td>10/1/2024</td>
                    </tr>
                    <tr>
                        <td>Doubles Bowling (Open)</td>
                        <td>10/14-11/6</td>
                        <td>9/19/2024</td>
                        <td>10/6/2024</td>
                    </tr>
                    <tr>
                        <td>Badminton Singles (M, W)</td>
                        <td>10/7 - 10/8, 10/13</td>
                        <td>9/19/2024</td>
                        <td>10/3/2024</td>
                    </tr>
                    <tr>
                        <td>Volleyball – 6 Player (M, W, U)</td>
                        <td>10/13/-11/20 & 12/2-12/5</td>
                        <td>9/19/2024</td>
                        <td>10/3/2024</td>
                    </tr>
                    <tr>
                        <td>Texas Hold’em Tournament (Open)</td>
                        <td>10/6</td>
                        <td>9/19/2024</td>
                        <td>10/3/2024</td>
                    </tr>
                    <tr>
                        <td>Cy5k (M, W)</td>
                        <td>9/28</td>
                        <td>9/11/2024</td>
                        <td>9/25/2024</td>
                    </tr>
                    <tr>
                        <td>9 Ball Pool (Open)</td>
                        <td>10/21 & 10/22, 10/27</td>
                        <td>10/2/2024</td>
                        <td>10/17/2024</td>
                    </tr>
                    <tr>
                        <td>Battleship H2O (Open)</td>
                        <td>10/24-11/20</td>
                        <td>10/2/2024</td>
                        <td>10/17/2024</td>
                    </tr>
                    <tr>
                        <td>Top Rope Competition (Open)</td>
                        <td>10/27</td>
                        <td>10/9/2024</td>
                        <td>10/23/2024</td>
                    </tr>
                    <tr>
                        <td>Pickleball Doubles (M, W, C)</td>
                        <td>10/28-10/29, 11/3, 11/4</td>
                        <td>10/10/2024</td>
                        <td>10/24/2024</td>
                    </tr>
                    <tr>
                        <td>Dodgeball (Open)</td>
                        <td>11/10</td>
                        <td>10/24/2024</td>
                        <td>11/6/2024</td>
                    </tr>
                    <tr>
                        <td>Bouldering Competition (Open)</td>
                        <td>11/17</td>
                        <td>10/31/2024</td>
                        <td>11/13/2024</td>
                    </tr>
                    <tr>
                        <td>3 on 3 Basketball (M, W)</td>
                        <td>11/17</td>
                        <td>11/3/2024</td>
                        <td>11/13/2024</td>
                    </tr>
                    <tr>
                        <td>Trivia Contest (Open)</td>
                        <td>12/3</td>
                        <td>11/10/2024</td>
                        <td>11/24/2024</td>
                    </tr>
                    <tr>
                        <td>3 Point Shoot (M,W)</td>
                        <td>11/7</td>
                        <td>10/24/2024</td>
                        <td>11/7/2024</td>
                    </tr>
                    <tr>
                        <td>NCAA Bowl Pick’em (Open)</td>
                        <td>12/16</td>
                        <td>12/2/2024</td>
                        <td>12/14/2024</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section>
            <h2>Spring 2025</h2>
            <p>Below is the schedule for Spring 2025 intramural sports. For detailed information or to register, please use the link provided.</p>
            <table>
                <thead>
                    <tr>
                        <th>Sport</th>
                        <th>Season Start/End Date</th>
                        <th>Registration Opens</th>
                        <th>Registration Closes</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Amazing Race Fantasy (Open)</td>
                        <td>TBD</td>
                        <td>TBD</td>
                        <td>TBD</td>
                    </tr>
                    <tr>
                        <td>Bachelor Fantasy (Open)</td>
                        <td>TBD</td>
                        <td>TBD</td>
                        <td>TBD</td>
                    </tr>
                    <tr>
                        <td>Drag Race Fantasy (Open)</td>
                        <td>TBD</td>
                        <td>TBD</td>
                        <td>TBD</td>
                    </tr>
                    <tr>
                        <td>WIN Night – Basketball</td>
                        <td>1/23/2025</td>
                        <td>–</td>
                        <td>1/23/2025</td>
                    </tr>
                    <tr>
                        <td>Wallyball (Open)</td>
                        <td>2/2-3/27</td>
                        <td>1/8/2025</td>
                        <td>1/26/2025</td>
                    </tr>
                    <tr>
                        <td>eSports - Rocket League (Open)</td>
                        <td>2/10-11 & 2/16</td>
                        <td>1/8/2025</td>
                        <td>2/6/2025</td>
                    </tr>
                    <tr>
                        <td>4 Person Team Bowling (Open, U)</td>
                        <td>2/3-3/27</td>
                        <td>1/8/2025</td>
                        <td>1/26/2025</td>
                    </tr>
                    <tr>
                        <td>Trampoline Dodgeball (M,W)</td>
                        <td>2/12-3/27</td>
                        <td>1/8/2025</td>
                        <td>1/26/2025</td>
                    </tr>
                    <tr>
                        <td>3 on 3 Basketball (M, W)</td>
                        <td>3/3-5/1</td>
                        <td>1/8/2025</td>
                        <td>1/26/2025</td>
                    </tr>
                    <tr>
                        <td>Billiards Tournament (Open)</td>
                        <td>3/8</td>
                        <td>2/6/2025</td>
                        <td>3/3/2025</td>
                    </tr>
                    <tr>
                        <td>Coed Kickball (Open)</td>
                        <td>3/9-5/1</td>
                        <td>1/8/2025</td>
                        <td>1/26/2025</td>
                    </tr>
                    <tr>
                        <td>2-Person Golf Scramble (Open)</td>
                        <td>4/4</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Table Tennis Singles (M, W)</td>
                        <td>4/6 & 4/7</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Trampoline Dodgeball (Open)</td>
                        <td>4/7</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Rock-Paper-Scissors Tournament (Open)</td>
                        <td>4/8</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>5 on 5 Basketball (M, W)</td>
                        <td>4/9-4/30</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Double Elimination Dodgeball (Open)</td>
                        <td>4/23-4/24</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Table Tennis Doubles (Open)</td>
                        <td>4/26</td>
                        <td>3/1/2025</td>
                        <td>3/20/2025</td>
                    </tr>
                    <tr>
                        <td>Rock-Paper-Scissors Tournament (Open)</td>
                        <td>5/1</td>
                        <td>4/1/2025</td>
                        <td>4/23/2025</td>
                    </tr>
                </tbody>
            </table>
        </section>

        <section>
            <h2>Registration</h2>
            <p>To register for any of the intramural sports or for more information, please visit our <a href="intramuralreg.jsp">registration page</a>.</p>
        </section>
    </main>
</body>
</html>
        
    <footer>
        <div class="footer-intro">
            <h2>Fit&Well</h2>
            <p>Elevate your well-being with every step you take. Commit to a journey of health and fitness, where every workout is a stride toward a stronger you. Nourish your body with balanced nutrition and mindful habits, and empower your mind with resilience and positivity. Celebrate the small victories and embrace the challenges, knowing each one brings you closer to your goals. Stay motivated and inspired, surround yourself with a supportive community, and let every day be an opportunity for growth. Together, we build a foundation of lasting wellness, balancing strength, flexibility, and mental clarity. Invest in yourself, and watch your potential unfold as we guide you through every phase of your fitness journey. Your path to a healthier, happier life starts here.</p>
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
    