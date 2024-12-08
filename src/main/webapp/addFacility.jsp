<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Facility</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            color: #004d00;
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="date"],
        input[type="time"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background: #004d00;
            color: #fff;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background: #005700;
        }
        p {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Add Facility Reservation</h1>
    <form action="FacilitiesServlet" method="post">
        <input type="hidden" name="action" value="create">
        
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="facility">Facility:</label>
        <select id="facility" name="facility" required>
            <option value="gym">Gym</option>
            <option value="pool">Pool</option>
            <option value="tennis_court">Tennis Court</option>
            <option value="basketball_court">Basketball Court</option>
        </select>
        
        <label for="reservation_date">Reservation Date:</label>
        <input type="date" id="reservation_date" name="reservation_date" required>
        
        <label for="reservation_time">Reservation Time:</label>
        <input type="text" id="reservation_time" name="reservation_time" placeholder="HH:MM:SS" required>
        
        <label for="details">Additional Details:</label>
        <textarea id="details" name="details" rows="4"></textarea>

        <input type="submit" value="Save Facility">
    </form>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
