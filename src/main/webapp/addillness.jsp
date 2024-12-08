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
    <h1>Illness and Injury Care</h1>
    <form action="IllnessServlet" method="post">
        <input type="hidden" name="action" value="create">
        
        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" required>
        
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>
        
        
        
         <label for="phone">Phone Number:</label>
         <input type="phone" id="phone" name="phone" required>
         
           <label for="services">Services:</label>
        <select id="services" name="services" required>
            <option value=" Primary Care"> Primary Care</option>
            <option value=" Urgent Care Services"> Urgent Care Services</option>
            <option value="Onsite Diagnostics">Onsite Diagnostics</option>
            <option value=" Allergy and Asthma Care"> Allergy and Asthma Care</option>
            <option value="  Skin and Wound Care">  Skin and Wound Care</option>
       </select>
       <p><strong> Venue:</strong></p>
    <form action="selectLocationServlet" method="post">
        <button type="submit" name="location" value="Fit&Well Sports Complex, 1 Paya Lebar Link, #05-01, Paya Lebar Quarter, Singapore, 408533" class="btn">
            National University Hospital (NUH) - Singapore, 5 Lower Kent Ridge Rd, Singapore 119074
        </button>
    </form>
            <a href="https://www.google.com/maps/dir//5+Lower+Kent+Ridge+Rd,+National+University+Hospital+(NUH)+-+Singapore,+Singapore+119074/@13.0081209,70.3635471,4z/data=!3m1!4b1!4m6!4m5!1m1!4e2!1m2!1m1!1s0x31da1a5180e324bb:0xb9734b40675a0ca3?entry=ttu&g_ep=EgoyMDI0MTIwNC4wIKXMDSoASAFQAw%3D%3D" target="_blank" class="btn">Get Directions</a>
            
        
        <label for="appointmentDate">Appointment Date:</label>
        <input type="date" id="appointmentDate" name="appointmentDate" required>
        
        <label for="appointmentTime">Appointment Time:</label>
       <select id="appointmentTime" name="appointmentTime" required>
                    <option value="">Select Time</option>
                    <option value="09:00">09:00 AM</option>
                    <option value="10:00">10:00 AM</option>
                    <option value="11:00">11:00 AM</option>
                    <option value="13:00">01:00 PM</option>
                    <option value="14:00">02:00 PM</option>
                    <option value="15:00">03:00 PM</option>
                </select>
              
            <label for="details"> Details:</label>
        <textarea id="details" name="details" rows="4"></textarea>

        <input type="submit" value="Submit Appointment Request">
    </form>
    
</body>
</html>
