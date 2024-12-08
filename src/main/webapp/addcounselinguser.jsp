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
        
           
       form input, form textarea ,form label , form select{
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
    <h1>Counseling</h1>
    <form action="MentalServletuser" method="post">
        <input type="hidden" name="action" value="create">
       <label for="fullName">Full Name:</label>
<input type="text" id="fullName" name="fullName" required>

<label for="email">Email:</label>
<input type="email" id="email" name="email" required>

<label for="phone">Phone Number:</label>
<input type="phone" id="phone" name="phone" required>

<label for="counselingType">Counseling Type:</label>
<select id="counselingType" name="counselingType" required>
    <option value="">Select Counseling Type</option>
    <option value="Individual Counseling">Individual Counseling</option>
    <option value="Group Therapy">Group Therapy</option>
    <option value="Family Counseling">Family Counseling</option>
    <option value="Crisis Counseling">Crisis Counseling</option>
    <option value="Career Counseling">Career Counseling</option>
</select>

<label for="preferredMethod">Preferred Communication Method:</label>
<select id="preferredMethod" name="preferredMethod" required>
    <option value="">Choose Communication Method</option>
    <option value="In-Person">In-Person</option>
    <option value="Video Call">Video Call</option>
    <option value="Phone Call">Phone Call</option>
</select>

<label for="appointmentDate">Preferred Appointment Date:</label>
<input type="date" id="appointmentDate" name="appointmentDate" required>

<label for="appointmentTime">Appointment Time:</label>
    <input type="text" id="appointmentTime" name="appointmentTime" pattern="([0-9]{1,2}):([0-9]{2}):([0-9]{2})" placeholder="h:mm:ss" required>


<label for="concerns">Primary Concerns :</label>
<textarea id="concerns" name="concerns" rows="4" placeholder=""></textarea>

<input type="submit" value="Request Counseling Appointment">
       
    </form>
    
</body>
</html>
