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
    <h1>Request my Health Records</h1>
    <form action="RequestRecordsServlet" method="post">
        <input type="hidden" name="action" value="create">
      
      <form action="/submitHealthRecordRequest" method="post">
    <!-- Patient Information -->
    <label for="fullName">Full Name:</label>
    <input type="text" id="fullName" name="fullName" required>

    <label for="dateOfBirth">Date of Birth:</label>
    <input type="date" id="dateOfBirth" name="dateOfBirth" required>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required>

    <label for="phoneNumber">Phone Number:</label>
    <input type="phone" id="phoneNumber" name="phoneNumber" required>

    <!-- Request Details -->
    <label for="recordType">Type of Record Requested:</label>
    <select id="recordType" name="recordType" required>
        <option value="">Select Record Type</option>
        <option value="Immunization Records">Immunization Records</option>
        <option value="Lab Results">Lab Results</option>
        <option value="Imaging Reports">Imaging Reports</option>
        <option value="Medical History">Medical History</option>
    </select>

    <label for="requestReason">Reason for Request:</label>
    <select id="requestReason" name="requestReason" required>
        <option value="">Select Reason</option>
        <option value="Personal Use">Personal Use</option>
        <option value="Transfer to Another Provider">Transfer to Another Provider</option>
        <option value="Insurance Purpose">Insurance Purpose</option>
        <option value="Legal Requirement">Legal Requirement</option>
    </select>

    <label for="preferredFormat">Preferred Format:</label>
    <select id="preferredFormat" name="preferredFormat" required>
        <option value="">Select Format</option>
        <option value="Digital Copy">Digital Copy</option>
        <option value="Paper Copy">Paper Copy</option>
    </select>
 
    
    <p><strong> Venue:</strong></p>
    <form action="selectLocationServlet" method="post">
        <button type="submit" name="location" value="Fit&Well Sports Complex, 1 Paya Lebar Link, #05-01, Paya Lebar Quarter, Singapore, 408533" class="btn">
            Fit&Well Sports Complex,Payabazaar
        </button>
    </form>

            <a href="https://www.google.com/maps" target="_blank" class="btn">Get Directions</a>
        </div>
    <label for="deliveryMethod">Delivery Method:</label>
    <select id="deliveryMethod" name="deliveryMethod" required>
        <option value="">Select Delivery Method</option>
        <option value="Email">Email</option>
        <option value="Physical Mail">Physical Mail</option>
        <option value="In-Person Pickup">In-Person Pickup</option>
    </select>

    <!-- Additional Information -->
    <label for="notes">Additional Details (Optional):</label>
    <textarea id="notes" name="notes" rows="4"></textarea>

    <!-- Authorization and Consent -->
    <label for="authorizationConsent">
        <input type="checkbox" id="authorizationConsent" name="authorizationConsent" required>
        I authorize the release of my health records as requested.
    </label>

    <!-- Submit Button -->
    <input type="submit" value="Request Health Records">
</form>
      
    
    
</body>
</html>
