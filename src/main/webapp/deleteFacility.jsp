<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Facility Reservation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            background-color: #f4f4f4;
        }
        h1 {
            color: #cc0000; /* Red color for delete action */
        }
        form {
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="submit"] {
            background: #cc0000; /* Red background for delete */
            color: #fff;
            border: none;
            cursor: pointer;
            font-weight: bold;
        }
        input[type="submit"]:hover {
            background: #e60000;
        }
    </style>
</head>
<body>
    <h1>Delete Facility Reservation</h1>

    <form action="FacilitiesServlet" method="post">
        <label for="reservation_id">Enter Reservation ID to Delete:</label>
        <input type="text" id="reservation_id" name="reservation_id" required>
        <input type="hidden" name="action" value="delete">
        <input type="submit" value="Delete Reservation">
    </form>
    <%
    String message = request.getParameter("message");
    if (message != null) {
        out.println("<p>" + message + "</p>");
    }
%>
    

    <%
        String reservationIdStr = request.getParameter("reservation_id");
        if (reservationIdStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                int reservationId = Integer.parseInt(reservationIdStr);
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM facility_reservations2 WHERE reservation_id=?")) {
                    stmt.setInt(1, reservationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            out.println("<p>Reservation ID <strong>" + reservationId + "</strong> found. Are you sure you want to delete this record?</p>");
                            out.println("<form action='FacilitiesServlet' method='post'>");
                            out.println("<input type='hidden' name='action' value='delete'>");
                            out.println("<input type='hidden' name='reservation_id' value='" + reservationId + "'>");
                            out.println("<input type='submit' value='Confirm Delete'>");
                            out.println("</form>");
                        } else {
                            out.println("<p>Reservation not found.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error retrieving reservation: " + e.getMessage() + "</p>");
            }
        }
    %>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
