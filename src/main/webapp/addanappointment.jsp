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
        input[type="phone"]{
         width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        
       
       
     form input, form textarea ,form label , form select, form button{
    font-size: 19px !important;
    
}
     
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
    <h1>Make an Appointment</h1>
 
        
  <form action="MakeAppointmentServlet" method="post">
  
  
    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="phone">Phone Number:</label>
    <input type="phone" id="phone" name="phone" required>

    <label for="serviceType">Select Service:</label>
    <select id="serviceType" name="serviceType" required>
        <option value="">Choose a Service</option>
        <option value="Preventative Care">Preventative Care</option>
        <option value="Physical Therapy">Physical Therapy</option>
        <option value="Reproductive Health">Reproductive Health</option>
        <option value="Pharmacy">Pharmacy</option>
    </select>

    <label for="appointmentDate">Date:</label>
    <input type="date" id="appointmentDate" name="appointmentDate" required>

    <label for="appointmentTime">Time:</label>
    <select id="appointmentTime" name="appointmentTime" required>
        <option value="">Select Time</option>
        <option value="09:00">09:00 AM</option>
        <option value="10:00">10:00 AM</option>
        <option value="11:00">11:00 AM</option>
        <option value="13:00">01:00 PM</option>
        <option value="14:00">02:00 PM</option>
        <option value="15:00">03:00 PM</option>
    </select>

    <label for="details">Additional Details :</label>
    <textarea id="details" name="details" rows="4" placeholder=""></textarea>

    <button type="submit">Schedule Appointment</button>
</form>
  

      
    
</body>
</html>
