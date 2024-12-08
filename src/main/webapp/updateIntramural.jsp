<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Intramural Registration</title>
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
    <h1>Update Intramural Registration</h1>

    <%
        String registrationIdStr = request.getParameter("id"); // Updated to "id"
        String name = "", phone = "", sport = "", status = "";
        Date reservationDate = null;
        Time reservationTime = null;

        if (registrationIdStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                int registrationId = Integer.parseInt(registrationIdStr);
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM intramural_registrations WHERE id=?")) { // Updated table and column name
                    stmt.setInt(1, registrationId);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            name = rs.getString("name"); // Updated column name
                            phone = rs.getString("phone"); // Updated column name
                            sport = rs.getString("sport"); // Updated column name
                            
                        } else {
                            out.println("<p>Registration not found.</p>");
                        }
                    }
                }
            } catch (Exception e) {
                out.println("<p>Error retrieving registration: " + e.getMessage() + "</p>");
            }
        }
    %>

    <form method="post">
        <label for="id">Enter Registration ID:</label> <!-- Updated to "id" -->
        <input type="text" id="id" name="id" value="<%= registrationIdStr != null ? registrationIdStr : "" %>" required>
        <input type="submit" value="Fetch Details">
    </form>

    <%
        if (registrationIdStr != null && !name.isEmpty()) {
    %>
    <div class="details">
        <div class="detail">
            <h4>Name:</h4>
            <p><%= name %></p>
        </div>
        <div class="detail">
            <h4>Phone:</h4>
            <p><%= phone %></p>
        </div>
        <div class="detail">
            <h4>Sport:</h4>
            <p><%= sport %></p>
        </div>
        
    </div>

    <form action="IntramuralServlet" method="post"> <!-- Updated to use IntramuralServlet -->
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= registrationIdStr %>"> <!-- Updated to "id" -->

        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required>

        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" required>

        <label for="sport">Sport:</label>
        <select id="sport" name="sport" required>
            <option value="soccer" <%= "soccer".equals(sport) ? "selected" : "" %>>Soccer</option>
            <option value="basketball" <%= "basketball".equals(sport) ? "selected" : "" %>>Basketball</option>
            <option value="volleyball" <%= "volleyball".equals(sport) ? "selected" : "" %>>Volleyball</option>
            <option value="tennis" <%= "tennis".equals(sport) ? "selected" : "" %>>Tennis</option>
        </select>

        

        <input type="submit" value="Update Registration">
    </form>
    <%
        }
    %>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
