<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meet Our Team - Mental Health</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Styling for the team page */
        .mental-health-sidebar {
            float: left;
            width: 25%;
            min-height: 100vh; /* Ensure the sidebar takes at least the full height of the viewport */
            padding: 20px;
            background-color: #f7f7f7;
            font-size: 1.1rem; /* Increase text size */
            line-height: 1.6; /* Increase line height for better readability */
        }

        .mental-health-sidebar h2 {
            color: #f07d00;
            font-size: 1.5rem; /* Increase heading size */
            margin-bottom: 20px; /* Add space below the heading */
        }

        .mental-health-sidebar .description {
            margin-bottom: 30px; /* Add more space below the description */
            font-size: 1.1rem;
            color: #666;
        }

        .mental-health-sidebar .contact-info {
            margin-top: 30px; /* Add more space above the contact info */
            font-size: 1.1rem;
            color: #333;
        }

        .mental-health-sidebar ul {
            list-style-type: none;
            padding: 0;
        }

        .mental-health-sidebar ul li {
            margin: 15px 0; /* Increase space between list items */
        }

        .mental-health-sidebar ul li a {
            text-decoration: none;
            color: #333;
            font-weight: bold;
            font-size: 1.1rem; /* Increase link size */
        }

        /* Highlight the current page link */
        .mental-health-sidebar ul li.active a {
            color: #ffffff;
            background-color: #f07d00;
            padding: 10px;
            border-radius: 5px;
        }

        .mental-health-sidebar ul li a:hover {
            color: #f07d00;
        }

        .team-content {
            float: right;
            width: 70%;
            padding: 20px;
            background-image: url('images/building.jpg'); /* Change the path as needed */
            background-size: cover;
            background-position: center;
        }

        .team-content h2 {
            color: #f07d00;
        }

        .team-member {
            display: flex;
            margin-bottom: 20px;
            border: 1px solid #e0e0e0;
            padding: 15px;
            border-radius: 5px;
            background-color: rgba(255, 255, 255, 0.8); /* Slightly transparent to make text readable */
        }

        .team-member img {
            border-radius: 50%;
            margin-right: 20px;
            width: 150px;
            height: 150px;
        }

        .team-member-info {
            max-width: 80%;
        }

        .team-member-info h3 {
            color: #f07d00;
            margin-bottom: 10px;
        }

        .team-member-info p {
            margin: 5px 0;
        }
    </style>
</head>
<body>
    <header>
        <!-- Header code here -->
    </header>
    <main>
        <div class="mental-health-sidebar">
            <h2>Mental Health</h2>
            <p class="description">
                We are dedicated to providing comprehensive mental health services to support your well-being. Our team is here to help with various concerns and provide resources for support.
            </p>
            <ul>
                <li><a href="#">Getting Started</a></li>
                <li><a href="#">Our Services</a></li>
                <li><a href="#">Emergency Care</a></li>
                <li><a href="#">Substance Use and Addiction Concerns</a></li>
                <li><a href="#">Mental Health Resources</a></li>
                <li><a href="#">Mental Health FAQs</a></li>
                <li><a href="#">Training Opportunities</a></li>
                <li class="active"><a href="#meet-our-team.jsp">Meet our Team</a></li>
            </ul>
            <p class="contact-info">
                For immediate assistance, call us at: <strong>434-243-5150</strong>
            </p>
        </div>
        <div class="team-content">
            <h2>Meet Our Team</h2>
            <div class="team-member">
                <img src="images/nicole.png" alt="Nicole Ruzek, PhD">
                <div class="team-member-info">
                    <h3>Chief Mental Health Officer</h3>
                    <p><strong>Nicole Ruzek, PhD</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:nicole@example.com">nicole@example.com</a></p>
                </div>
            </div>
            <div class="team-member">
                <img src="images/prasanna.jpg" alt="Prasanna Madasu">
                <div class="team-member-info">
                    <h3>Clinical Care Manager</h3>
                    <p><strong>Prasanna Madasu</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:prasanna@example.com">prasanna@example.com</a></p>
                </div>
            </div>
            <div class="team-member">
                <img src="images/shekhar.jpg" alt="Shekhar, PhD">
                <div class="team-member-info">
                    <h3>Director Counseling and Psychological Services</h3>
                    <p><strong>Shekhar, PhD</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:shekhar@example.com">shekhar@example.com</a></p>
                </div>
            </div>
            <div class="team-member">
                <img src="images/vasavi.jpg" alt="Vasavi Madasu">
                <div class="team-member-info">
                    <h3>Embedded Psychotherapist at the School of Architecture</h3>
                    <p><strong>Vasavi Madasu</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:vasavi@example.com">vasavi@example.com</a></p>
                </div>
            </div>
            <div class="team-member">
                <img src="images/shabnam.jpg" alt="Shabnam Aara, PhD">
                <div class="team-member-info">
                    <h3>Senior Administrative Assistant</h3>
                    <p><strong>Shabnam Aara, PhD</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:shabnam@example.com">shabnam@example.com</a></p>
                </div>
            </div>
            <div class="team-member">
                <img src="images/ram.jpg" alt="Sri Ram, PhD">
                <div class="team-member-info">
                    <h3>Staff Psychotherapist</h3>
                    <p><strong>Sri Ram, PhD</strong></p>
                    <p>Contact: 434-243-5150</p>
                    <p>Email: <a href="mailto:sri@example.com">sri@example.com</a></p>
                </div>
            </div>
        </div>
        <div style="clear: both;"></div>
    </main>
    <footer>
        <!-- Footer code here -->
    </footer>
</body>
</html>
