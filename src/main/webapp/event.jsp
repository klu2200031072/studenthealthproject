<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fit&Well - Event Calendar</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        /* General styling */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            text-align: center; /* Centers text inside body */
        }
        header, footer {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
        }
        header .header-flex, footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        main {
            padding: 20px;
            display: flex;
            flex-direction: column;
            align-items: center; /* Centers child elements horizontally */
        }
        h1, h2 {
            color: #b11226;
        }

        /* Navigation */
        .dashboard-nav ul {
            list-style-type: none;
            padding: 0;
            display: flex;
            gap: 20px;
        }
        .dashboard-nav ul li {
            display: inline-block;
        }
        .dashboard-nav ul li a {
            color: white;
            text-decoration: none;
        }

        /* Event section styling */
        .event-availability, .booking-section {
            width: 60%; /* Set a max-width for content */
            margin: 20px auto; /* Horizontally center */
            text-align: left; /* Align text inside content blocks */
        }

        .event-item {
            margin-bottom: 20px;
        }
        .event-item h3 {
            margin: 0;
        }
        .event-item p {
            margin: 5px 0;
        }

        /* Booking form styles */
        .booking-section button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .booking-section button:hover {
            background-color: #45a049;
        }

        /* Centering form content */
        form {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center form elements */
        }

        select {
            padding: 10px;
            margin-bottom: 15px;
            width: 50%;
        }

    </style>
</head>
<body>
    <!-- Header (Unchanged) -->
    <header>
        <div class="header-flex">
            <div class="logo-container">
                <img src="images/university-logo.png" alt="University Logo" class="logo" style="height: 60px;" />
                <h2>Fit&Well</h2>
            </div>
            <div class="user-info">
                <%
                    String username = (String) session.getAttribute("username");
                    if (username != null) {
                        out.print("Logged in as: <span style='color: white;'>" + username + "</span>");
                    } else {
                        out.print("Not logged in");
                    }
                %>
            </div>
        </div>
        <!-- Dashboard Navigation (Neat and Ordered) -->
        <div class="dashboard-nav">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="unit.jsp">Unit Directory</a></li>
                <li><a href="event.jsp">Event Calendar</a></li>
                <li><a href="eligibility.jsp">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
                <li><a href="#">Rec Portal</a></li>
                <li><a href="#" class="cyclone-support">Student Health Support</a></li>
            </ul>
        </div>
    </header>

    <!-- Main Content -->
    <main>
        <!-- Breadcrumbs -->
        <div>
            <a href="home.jsp">Home</a> > <span>Event Availability</span>
        </div>

        <!-- Event Booking Section -->
        <section class="booking-section">
            <h2>Register for Event</h2>
            <form action="registerEvent.jsp" method="post">
                <label for="event-select">Select Event:</label>
                <select id="event-select" name="event">
                    <option value="yoga">Yoga for Beginners</option>
                    <option value="nutrition">Nutrition Workshop</option>
                    <option value="cooking">Cooking for Wellness</option>
                    <option value="mental-health">Mental Health Webinar</option>
                    <option value="first-aid">First Aid Training</option>
                    <option value="bootcamp">Fitness Bootcamp</option>
                    <option value="meditation">Mindfulness Meditation</option>
                    <option value="swim">Swim Lessons</option>
                </select>
                <button type="submit">Register</button>
            </form>
        </section>

        <!-- Event Availability Section -->
        <section class="event-availability">
            <h2>Event Availability</h2>
            
            <!-- Available Events -->
            <div class="available-events">
                <h3>Available Events</h3>
                <div class="event-item">
                    <h3>Yoga for Beginners</h3>
                    <p>Time: 10:00 AM | Date: 5th June 2024</p>
                    <p>Location: Wellness Room,guntur</p>
                </div>
                <div class="event-item">
                    <h3>Nutrition Workshop</h3>
                    <p>Time: 12:00 PM | Date: 8th June 2024</p>
                    <p>Location: Health Hall,guntur</p>
                </div>
                <div class="event-item">
                    <h3>Cooking for Wellness</h3>
                    <p>Time: 2:00 PM | Date: 10th June 2024</p>
                    <p>Location: Kitchen Studio,guntur</p>
                </div>
                <div class="event-item">
                    <h3>Mental Health Webinar</h3>
                    <p>Time: 3:00 PM | Date: 12th June 2024</p>
                    <p>Location: Online in teams</p>
                </div>
                <div class="event-item">
                    <h3>First Aid Training</h3>
                    <p>Time: 11:00 AM | Date: 15th June 2024</p>
                    <p>Location: Health Hall.guntur</p>
                </div>
                <div class="event-item">
                    <h3>Fitness Bootcamp</h3>
                    <p>Time: 9:00 AM | Date: 18th June 2024</p>
                    <p>Location: Gymnasium, guntur</p>
                </div>
            </div>

            <!-- Unavailable Events -->
            <div class="unavailable-events">
                <h3>Unavailable Events</h3>
                <div class="event-item">
                    <h3>Mindfulness Meditation</h3>
                    <p>Unavailable at this time.</p>
                </div>
                <div class="event-item">
                    <h3>Swim Lessons</h3>
                    <p>Unavailable at this time.</p>
                </div>
                <div class="event-item">
                    <h3>Stress Management Seminar</h3>
                    <p>Unavailable at this time.</p>
                </div>
                <div class="event-item">
                    <h3>Mental Health Counseling</h3>
                    <p>Unavailable at this time.</p>
                </div>
            </div>
        </section>
    </main>
</body>
</html>