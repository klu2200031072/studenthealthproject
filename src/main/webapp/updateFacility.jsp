<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Facility Reservation</title>
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
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="date"],
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
        .details {
            background: #e6ffe6; /* Light green background for details */
            padding: 10px;
            border-radius: 5px;
            margin-top: 20px;
            display: flex;
            flex-wrap: wrap;
        }
        .detail {
            flex: 1 1 200px; /* Responsive sizing */
            margin: 5px;
            padding: 10px;
            background: #ccffcc; /* Light green for individual details */
            border: 1px solid #99cc99;
            border-radius: 5px;
        }
        .detail h4 {
            margin: 0;
        }
    </style>
</head>
<body>
    <h1>Update Facility Reservation</h1>

    <%
        String reservationIdStr = request.getParameter("reservation_id");
        String name = "", email = "", facility = "", details = "";
        Date reservationDate = null;
        Time reservationTime = null;

        if (reservationIdStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                int reservationId = Integer.parseInt(reservationIdStr);
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM facility_reservations2 WHERE reservation_id=?")) {
                    stmt.setInt(1, reservationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            name = rs.getString("name");
                            email = rs.getString("email");
                            facility = rs.getString("facility");
                            reservationDate = rs.getDate("reservation_date");
                            reservationTime = rs.getTime("reservation_time");
                            details = rs.getString("details");
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

    <form method="post">
        <label for="reservation_id">Enter Reservation ID:</label>
        <input type="text" id="reservation_id" name="reservation_id" value="<%= reservationIdStr != null ? reservationIdStr : "" %>" required>
        <input type="submit" value="Fetch Details">
    </form>

    <%
        if (reservationIdStr != null && !name.isEmpty()) {
    %>
    <div class="details">
        <div class="detail">
            <h4>Name:</h4>
            <p><%= name %></p>
        </div>
        <div class="detail">
            <h4>Email:</h4>
            <p><%= email %></p>
        </div>
        <div class="detail">
            <h4>Facility:</h4>
            <p><%= facility %></p>
        </div>
        <div class="detail">
            <h4>Reservation Date:</h4>
            <p><%= reservationDate != null ? reservationDate.toString() : "" %></p>
        </div>
        <div class="detail">
            <h4>Reservation Time:</h4>
            <p><%= reservationTime != null ? reservationTime.toString() : "" %></p>
        </div>
        <div class="detail">
            <h4>Details:</h4>
            <p><%= details %></p>
        </div>
    </div>

    <form action="FacilitiesServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="reservation_id" value="<%= reservationIdStr %>">

        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required>

        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required>

        <label for="facility">Facility:</label>
        <select id="facility" name="facility" required>
            <option value="gym" <%= "gym".equals(facility) ? "selected" : "" %>>Gym</option>
            <option value="pool" <%= "pool".equals(facility) ? "selected" : "" %>>Pool</option>
            <option value="tennis_court" <%= "tennis_court".equals(facility) ? "selected" : "" %>>Tennis Court</option>
            <option value="basketball_court" <%= "basketball_court".equals(facility) ? "selected" : "" %>>Basketball Court</option>
        </select>

        <label for="reservation_date">Reservation Date:</label>
        <input type="date" id="reservation_date" name="reservation_date" value="<%= reservationDate != null ? reservationDate.toString() : "" %>" required>

        <label for="reservation_time">Reservation Time:</label>
        <input type="text" id="reservation_time" name="reservation_time" value="<%= reservationTime != null ? reservationTime.toString() : "" %>" placeholder="HH:MM:SS" required>

        <label for="details">Additional Details:</label>
        <textarea id="details" name="details" rows="4"><%= details %></textarea>

        <input type="submit" value="Update Facility">
    </form>
    <%
        }
    %>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
