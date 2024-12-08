<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Unit Directory</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }

        header {
            background-color: #28a745; /* Green color */
            color: white;
            padding: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h2 {
            margin: 0;
            font-size: 1.5em;
        }

        .dashboard-nav {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .dashboard-nav ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .dashboard-nav ul li {
            margin-right: 20px;
        }

        .dashboard-nav ul li a {
            text-decoration: none;
            color: white; /* Make navigation text white */
            font-weight: bold;
        }

        .container {
            padding: 20px;
        }

        .appointment-form {
            margin: 20px auto;
            padding: 20px;
            background-color: white;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
        }

        .appointment-form h2 {
            color: #28a745; /* Green for headings */
            margin-bottom: 20px;
        }

        .appointment-form label {
            font-weight: bold;
            color: #28a745; /* Green for labels */
        }

        .appointment-form select, .appointment-form input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .appointment-form button {
            background-color: #28a745; /* Green for buttons */
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            width: 100%;
        }

        .appointment-form button:hover {
            background-color: #218838; /* Slightly darker green on hover */
        }

        .confirmation-message {
            text-align: center;
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            margin-top: 20px;
            border: 1px solid #c3e6cb;
            border-radius: 5px;
        }
    </style>
</head>
<body>

    <header>
        <h2>Fit&Well - Doctor Appointment Booking</h2>
        <!-- Dashboard Navigation inside the header -->
        <div class="dashboard-nav">
            <ul>
                <li><a href="home.jsp">Home</a></li>
                <li><a href="event.jsp">Event Calendar</a></li>
                <li><a href="eligibility.jsp">Eligibility</a></li>
                <li><a href="#">Policies & Forms</a></li>
            </ul>
        </div>
    </header>

    <div class="container">
        <!-- Appointment Booking Form -->
        <div class="appointment-form">
            <h2>Book an Appointment</h2>
            <form action="unit.jsp" method="post">
                <label for="doctor">Choose a Doctor:</label>
                <select id="doctor" name="doctor">
                    <option value="Nicole Ruzek, PhD">Nicole Ruzek, PhD (Chief Mental Health Officer)</option>
                    <option value="Jitendra Sai">Jitendra Sai (Clinical Care Manager)</option>
                    <option value="Ramesh, PhD">Ramesh, PhD (Director Counseling and Psychological Services)</option>
                    <option value="Suresh">Suresh (Psychotherapist)</option>
                </select>

                <label for="date">Choose Date:</label>
                <input type="date" id="date" name="date" required />

                <label for="time">Choose Time:</label>
                <input type="time" id="time" name="time" required />

                <button type="submit">Book Appointment</button>
            </form>

            <!-- Confirmation Message -->
            <%
                // Retrieve the appointment data from the form submission
                String doctor = request.getParameter("doctor");
                String date = request.getParameter("date");
                String time = request.getParameter("time");

                if (doctor != null && date != null && time != null) {
                    // You could save the appointment data in a database or session here

                    out.println("<div class='confirmation-message'>");
                    out.println("Appointment booked with <strong>" + doctor + "</strong> on <strong>" + date + "</strong> at <strong>" + time + "</strong>.");
                    out.println("</div>");
                }
            %>
        </div>
    </div>

</body>
</html>
