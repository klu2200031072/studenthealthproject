<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Counseling Appointment</title>
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
        input[type="tel"],
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
    <h1>Update Counseling Appointment</h1>

    <%
        String appointmentIdStr = request.getParameter("id");
        String fullName = "", email = "", phone = "", counselingType = "", preferredMethod = "", details = "";
        Date appointmentDate = null;
        Time appointmentTime = null;

        if (appointmentIdStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                int appointmentId = Integer.parseInt(appointmentIdStr);
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM counseling_appointments WHERE id=?")) {
                    stmt.setInt(1, appointmentId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            fullName = rs.getString("fullName");
                            email = rs.getString("email");
                            phone = rs.getString("phone");
                            counselingType = rs.getString("counselingType");
                            preferredMethod = rs.getString("preferredMethod");
                            appointmentDate = rs.getDate("appointmentDate");
                            appointmentTime = rs.getTime("appointmentTime");
                            details = rs.getString("concerns");
                        } else {
                            out.println("<p>Appointment not found.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error retrieving appointment: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form method="post">
        <label for="id">Enter Appointment ID:</label>
        <input type="text" id="id" name="id" value="<%= appointmentIdStr != null ? appointmentIdStr : "" %>" required>
        <input type="submit" value="Fetch Details">
    </form>

    <%
        if (appointmentIdStr != null && !fullName.isEmpty()) {
    %>
    <div class="details">
        <div class="detail">
            <h4>Full Name:</h4>
            <p><%= fullName %></p>
        </div>
        <div class="detail">
            <h4>Email:</h4>
            <p><%= email %></p>
        </div>
        <div class="detail">
            <h4>Phone:</h4>
            <p><%= phone %></p>
        </div>
        <div class="detail">
            <h4>Counseling Type:</h4>
            <p><%= counselingType %></p>
        </div>
        <div class="detail">
            <h4>Preferred Method:</h4>
            <p><%= preferredMethod %></p>
        </div>
        <div class="detail">
            <h4>Appointment Date:</h4>
            <p><%= appointmentDate != null ? appointmentDate.toString() : "" %></p>
        </div>
        <div class="detail">
            <h4>Appointment Time:</h4>
            <p><%= appointmentTime != null ? appointmentTime.toString() : "" %></p>
        </div>
        <div class="detail">
            <h4>Concerns:</h4>
            <p><%= details %></p>
        </div>
    </div>

    <form action="MentalServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= appointmentIdStr %>">

        <label for="fullName">Full Name:</label>
        <input type="text" id="fullName" name="fullName" value="<%= fullName %>" required>

        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required>

        <label for="phone">Phone Number:</label>
        <input type="tel" id="phone" name="phone" value="<%= phone %>" required>

        <label for="counselingType">Counseling Type:</label>
        <select id="counselingType" name="counselingType" required>
            <option value="individual" <%= "individual".equals(counselingType) ? "selected" : "" %>>Individual</option>
            <option value="group" <%= "group".equals(counselingType) ? "selected" : "" %>>Group</option>
            <option value="couples" <%= "couples".equals(counselingType) ? "selected" : "" %>>Couples</option>
        </select>

        <label for="preferredMethod">Preferred Method:</label>
        <select id="preferredMethod" name="preferredMethod" required>
            <option value="in_person" <%= "in_person".equals(preferredMethod) ? "selected" : "" %>>In Person</option>
            <option value="phone-call" <%= "phone-call".equals(preferredMethod) ? "selected" : "" %>>phone-call</option>
            <option value="video-call" <%= "video-call".equals(preferredMethod) ? "selected" : "" %>>video-call</option>
        </select>

        <label for="appointment_date">Appointment Date:</label>
        <input type="date" id="appointment_date" name="appointment_date" value="<%= appointmentDate != null ? appointmentDate.toString() : "" %>" required>

        <label for="appointment_time">Appointment Time:</label>
       <input type="text" id="appointment_time" name="appointment_time" value="<%= appointmentTime != null ? appointmentTime.toString() : "" %>" placeholder="HH:MM:SS" required>
       
        <label for="concerns">Concerns:</label>
        <textarea id="concerns" name="concerns" rows="4"><%= details %></textarea>

        <input type="submit" value="Update Appointment">
    </form>
    <%
        }
    %>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
