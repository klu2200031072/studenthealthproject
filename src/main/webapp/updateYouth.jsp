<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Youth Camp Registration</title>
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
            background: #e6ffe6;
            padding: 10px;
            border-radius: 5px;
            margin-top: 20px;
            display: flex;
            flex-wrap: wrap;
        }
        .detail {
            flex: 1 1 200px;
            margin: 5px;
            padding: 10px;
            background: #ccffcc;
            border: 1px solid #99cc99;
            border-radius: 5px;
        }
        .detail h4 {
            margin: 0;
        }
    </style>
</head>
<body>
    <h1>Update Youth Camp Registration</h1>

    <%
        String idStr = request.getParameter("id");
        String name = "", email = "", phone = "", age = "", gender = "", camp = "", tshirtSize = "", 
               allergies = "", emergencyContactName = "", emergencyContactPhone = "", comments = "";
        String status = "";

        if (idStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                int id = Integer.parseInt(idStr);
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM youth_camp_registrations WHERE id=?")) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            name = rs.getString("name");
                            email = rs.getString("email");
                            phone = rs.getString("phone");
                            age = rs.getString("age");
                            gender = rs.getString("gender");
                            camp = rs.getString("camp");
                            tshirtSize = rs.getString("tshirt_size");
                            allergies = rs.getString("allergies");
                            emergencyContactName = rs.getString("emergency_contact_name");
                            emergencyContactPhone = rs.getString("emergency_contact_phone");
                            comments = rs.getString("comments");
                            status = rs.getString("status");
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
        <label for="id">Enter Registration ID:</label>
        <input type="text" id="id" name="id" value="<%= idStr != null ? idStr : "" %>" required>
        <input type="submit" value="Fetch Details">
    </form>

    <%
        if (idStr != null && !name.isEmpty()) {
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
            <h4>Phone:</h4>
            <p><%= phone %></p>
        </div>
        <div class="detail">
            <h4>Age:</h4>
            <p><%= age %></p>
        </div>
        <div class="detail">
            <h4>Gender:</h4>
            <p><%= gender %></p>
        </div>
        <div class="detail">
            <h4>Camp:</h4>
            <p><%= camp %></p>
        </div>
        <div class="detail">
            <h4>T-shirt Size:</h4>
            <p><%= tshirtSize %></p>
        </div>
        <div class="detail">
            <h4>Allergies:</h4>
            <p><%= allergies %></p>
        </div>
        <div class="detail">
            <h4>Emergency Contact Name:</h4>
            <p><%= emergencyContactName %></p>
        </div>
        <div class="detail">
            <h4>Emergency Contact Phone:</h4>
            <p><%= emergencyContactPhone %></p>
        </div>
        <div class="detail">
            <h4>Comments:</h4>
            <p><%= comments %></p>
        </div>
        <div class="detail">
            <h4>Status:</h4>
            <p><%= status %></p>
        </div>
    </div>

    <form action="YouthServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="<%= idStr %>">

        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required>

        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" value="<%= email %>" required>

        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" value="<%= phone %>" required>

        <label for="age">Age:</label>
        <input type="text" id="age" name="age" value="<%= age %>" required>

        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="male" <%= "male".equals(gender) ? "selected" : "" %>>Male</option>
            <option value="female" <%= "female".equals(gender) ? "selected" : "" %>>Female</option>
        </select>

        <label for="camp">Camp:</label>
        <input type="text" id="camp" name="camp" value="<%= camp %>" required>

        <label for="tshirt_size">T-shirt Size:</label>
        <input type="text" id="tshirt_size" name="tshirt_size" value="<%= tshirtSize %>" required>

        <label for="allergies">Allergies:</label>
        <input type="text" id="allergies" name="allergies" value="<%= allergies %>">

        <label for="emergency_contact_name">Emergency Contact Name:</label>
        <input type="text" id="emergency_contact_name" name="emergency_contact_name" value="<%= emergencyContactName %>" required>

        <label for="emergency_contact_phone">Emergency Contact Phone:</label>
        <input type="text" id="emergency_contact_phone" name="emergency_contact_phone" value="<%= emergencyContactPhone %>" required>

        <label for="comments">Additional Comments:</label>
        <textarea id="comments" name="comments" rows="4"><%= comments %></textarea>

        <input type="submit" value="Update Registration">
    </form>
    <%
        }
    %>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
