<!DOCTYPE html>
<html>
<head>
    <title>Schedule Appointment</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        /* Basic styling for the schedule page */
        body {
            font-family: Arial, sans-serif;
            background-image: url('images/building.jpg'); /* Add your background image path here */
            background-size: cover;
            background-position: center;
            margin: 0;
            padding: 0;
        }

        .header-container {
            background-color: rgba(0, 71, 171, 0.9); /* Slightly transparent background */
            color: white;
            padding: 20px;
            text-align: center;
        }

        .header-container h1 {
            margin: 0;
        }

        .content {
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent background for content */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h2 {
            color: #0047ab;
        }

        .appointment-form label {
            display: block;
            margin: 15px 0 5px;
            color: #333;
        }

        .appointment-form input[type="text"],
        .appointment-form input[type="date"],
        .appointment-form input[type="time"],
        .appointment-form select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        .appointment-form button {
            background-color: #0047ab;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        .appointment-form button:hover {
            background-color: #003080;
        }
    </style>
</head>
<body>
    <div class="header-container">
        <img src="images/university-logo.png" alt="University Logo" class="logo" style="vertical-align: middle; height: 50px;"/>
        <h1>KL UNIVERSITY</h1>
        <h2>Schedule an Appointment</h2>
    </div>
    <div class="content">
        <% String message = (String) request.getAttribute("message"); %>
        <% if (message != null) { %>
            <div style="color: green; text-align: center; margin-top: 20px;">
                <%= message %>
            </div>
        <% } %>

        <h2>Book Your Appointment</h2>
        <form class="appointment-form" action="AppointmentServlet" method="post">
            <label for="fullname">Full Name:</label>
            <input type="text" id="fullname" name="fullname" required>
            
            <label for="studentid">Student ID:</label>
            <input type="text" id="studentid" name="studentid" required>

            <label for="department">Department:</label>
            <select id="department" name="department" required>
                <option value="">Select your department</option>
                <option value="mental_health">Mental Health</option>
                <option value="disability_services">Disability Services</option>
                <option value="medical_services">Medical Services</option>
                <option value="well_being">Well-Being</option>
            </select>

            <label for="appointment_date">Appointment Date:</label>
            <input type="date" id="appointment_date" name="appointment_date" required>

            <label for="appointment_time">Appointment Time:</label>
            <input type="time" id="appointment_time" name="appointment_time" required>

            <button type="submit">Schedule Appointment</button>
        </form>
    </div>
</body>
</html>
