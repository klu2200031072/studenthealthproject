<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Health and Wellness</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <script src="js/script.js" defer></script>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            background-image: url('images/home.jpg'); /* Set background image */
            background-size: cover; /* Cover the entire body */
            background-position: center; /* Center the image */
            background-repeat: no-repeat; /* Prevent tiling */
        }

        header {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%; 
            margin-bottom: 0; /* Remove bottom margin */
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent white */
            padding: 10px 0; /* Added padding for better spacing */
        }

        .header-container {
            width: 100%;
        }

        .header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 5px 20px; /* Reduced padding */
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
            margin: 0 10px; /* Reduced margin */
        }

        .sub-header {
            width: 100%; 
            padding: 10px 0; /* Reduced padding */
            background-color: #4CAF50; 
            text-align: center; 
        }

        .sub-header h1 {
            font-size: 24px; /* Reduced font size */
            color: white;
            margin: 0;
        }

        .sub-nav {
            padding: 5px 0; /* Reduced padding */
        }

        .sub-nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            justify-content: center; 
        }

        .sub-nav li {
            margin: 0 10px; /* Reduced margin */
        }

        main {
            flex-grow: 1; 
            display: flex;
            justify-content: center; /* Center content */
            padding: 0; /* Remove padding */
        }

        .new-students-section {
            padding: 15px; /* Reduced padding for a more compact look */
            text-align: center; 
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent background */
            border-radius: 8px; 
            margin: 20px auto; /* Center the section with automatic margins */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); 
            max-width: 500px; /* Further reduced max width */
            width: 90%; /* Make it responsive */
        }

        .new-students-section h3 {
            font-size: 22px; /* Adjusted font size for the heading */
            margin-bottom: 10px; /* Reduced margin */
            color: #333; /* Dark color for the heading */
        }

        .new-students-section p {
            font-size: 14px; /* Reduced font size */
            line-height: 1.5; /* Adjusted line height for compactness */
            margin-bottom: 10px; /* Reduced margin */
        }

        .new-students-section ul {
            list-style-type: none; 
            padding: 0; 
            margin: 10px 0; /* Reduced margin */
        }

        .new-students-section li {
            font-size: 14px; /* Consistent font size for list items */
            line-height: 1.5; 
            margin-bottom: 8px; /* Reduced margin */
            text-align: left; 
        }

        .cta-button {
            padding: 8px 16px; /* Reduced button padding */
            font-size: 14px; /* Button font size */
            color: white; /* Button text color */
            background-color: #4CAF50; /* Button background color */
            border: none; /* Remove border */
            border-radius: 5px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s; /* Smooth transition */
        }

        .cta-button:hover {
            background-color: #45a049; /* Darker green on hover */
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
            </div>
        </div>

        <div class="sub-header">
            <h1>Student Health and Wellness</h1>
        </div>

        <nav class="sub-nav">
            <ul>
                <li><a href="login.jsp">Login</a></li>
                <li><a href="adminlogin.jsp">AdminLogin</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section class="new-students-section">
    <h3>New to Fit&Well? &#x1F31F;</h3>
    <p>
        Welcome aboard! &#x1F389; We're excited to have you as part of our community. At Fit&Well, we prioritize your holistic well-being with a range of services tailored to support you through every step of your academic journey. Our experienced team is here to:
    </p>
    <ul>
        <li>&#x1F4BC; <strong>Offer Comprehensive Care:</strong> From routine check-ups to specialized health services.</li>
        <li>&#x1F91D; <strong>Provide Personalized Support:</strong> Access counseling and wellness resources tailored to your needs.</li>
        <li>&#x1F3C3;&#xFE0F; <strong>Encourage Healthy Living:</strong> Explore our resources to help you stay fit, balanced, and successful.</li>
    </ul>
    <p>
        Connect with our dedicated staff, explore the features of our app, and start your journey towards optimal health and well-being today! &#x1F308;
    </p>

    <div class="motivational-quote">
        <blockquote>
            "The journey of a thousand miles begins with one step." Lao Tzu &#x1F331;
        </blockquote>
    </div>

    <div class="cta">
        <p>Ready to take the first step? &#x2728; <a href="signup.jsp" class="cta-button">Sign Up Now!</a> &#x2728;</p>
    </div>
</section>
        
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