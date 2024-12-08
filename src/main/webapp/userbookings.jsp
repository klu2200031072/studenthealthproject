<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Bookings</title>
    <style>
        body { font-family: Arial, sans-serif; }
        table { border-collapse: collapse; width: 50%; margin: 0 auto; }
        th, td { padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        tr:nth-child(even) { background-color: #f9f9f9; }
        .message { color: red; text-align: center; font-weight: bold; }
    </style>
</head>
<body>

<h1 style="text-align:center;">User Booking Details</h1>

<!-- Display error or success message -->
<c:if test="${not empty message}">
    <div class="message">${message}</div>
</c:if>

<!-- Form to enter email -->
<form action="UserBookingsServlet" method="POST" style="text-align: center; margin-bottom: 20px;">
    <label for="email">Enter your Email: </label>
    <input type="email" id="email" name="email" required>
    <button type="submit">Submit</button>
</form>

<!-- Display user booking details -->
<c:if test="${not empty id}">
    <table border="1">
        <tr>
            <th>ID</th>
            <td>${id}</td>
        </tr>
        <tr>
            <th>Name</th>
            <td>${name}</td>
        </tr>
        <tr>
            <th>Email</th>
            <td>${email}</td>
        </tr>
        <tr>
            <th>Phone</th>
            <td>${phone}</td>
        </tr>
        <tr>
            <th>Sport</th>
            <td>${sport}</td>
        </tr>
        <tr>
            <th>Status</th>
            <td>${status}</td>
        </tr>
    </table>
</c:if>

</body>
</html>
