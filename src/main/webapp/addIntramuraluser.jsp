<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Intramural Registration</title>
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
        select {
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
          .btn {
    display: inline-block;
    padding: 15px 20px; /* Adjust padding for a larger button */
    color: white;
    background-color: #4CAF50;
    text-decoration: none;
    border-radius: 5px;
    border: none;
    cursor: pointer;
    font-size: 16px; /* Adjust font size for better readability */
    width: 100%; /* Make the button span the full width of its container */
    max-width: 600px; /* Set a maximum width for the button */
    margin: 10px auto; /* Center the button within the container */
}
.btn:hover {
    background-color: #45a049;
}
        
    </style>
</head>
<body>
    <h1>Add Intramural Registration</h1>
    <form action="IntramuralServletuser" method="post">
        <input type="hidden" name="action" value="create">
        
        <!-- Name -->
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" required>
        
        <!-- Email -->
        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" required>
        
        <!-- Phone -->
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" required>
        
        <!-- Sport -->
        <label for="sport">Sport:</label>
        <select id="sport" name="sport" required>
            <option value="basketball">Basketball</option>
            <option value="soccer">Soccer</option>
            <option value="volleyball">Volleyball</option>
            <option value="tennis">Tennis</option>
        </select>
         <div class="venue-info">
    <p><strong> Venue:</strong></p>
    <form action="selectLocationServlet" method="post">
        <button type="submit" name="location" value="Fit&Well Sports Complex, 1 Paya Lebar Link, #05-01, Paya Lebar Quarter, Singapore, 408533" class="btn">
            Sports Complex,Payabazaar
        </button>
    </form>
            
            <p>Basketball:Opposite to Sports complex<br>Tennis Court:Near to Sports Complex<br>Soccer:Next to Tennis Court<br>Volleyball:Ground area</p>
            <p>Operating Hours:<br>Monday to Saturday: 6:00 AM - 10:00 PM<br>Sunday: 8:00 AM - 8:00 PM</p>
            <a href="https://www.google.com/maps" target="_blank" class="btn">Get Directions</a>
        </div>
        
        <!-- Submit -->
        <input type="submit" value="Save Registration">
    </form>
</body>
</html>
