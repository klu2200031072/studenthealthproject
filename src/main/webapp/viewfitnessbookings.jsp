<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>View Bookings</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin-top: 50px;
        }
        .booking-details {
            font-size: 20px;
            color: green;
            margin: 20px auto;
            border: 1px solid #ccc;
            padding: 20px;
            width: 80%;
            max-width: 600px;
            background-color: #f9f9f9;
        }
        .back-link {
            margin-top: 20px;
            font-size: 18px;
        }
    </style>
</head>
<body>

    <h2>Check Booking Status</h2>
    <form method="post" action="ViewFitnessBookingsServlet">
        <input type="text" name="id" placeholder="Enter Registration ID" required>
        <input type="submit" value="Check Status">
    </form>

    <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
    %>
        <div class="booking-details">
            <h2><%= message %></h2>
        </div>
    <%
        } else if (request.getAttribute("error") != null) {
    %>
        <div class="booking-details">
            <h3><%= request.getAttribute("error") %></h3>
        </div>
    <%
        }
    %>
    <div class="back-link">
        <a href="fitnessreg.jsp">Back to Facility Reservations</a>
    </div>
</body>
</html>
