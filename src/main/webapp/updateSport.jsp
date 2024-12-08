<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Sport Club Registration</title>
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
    <h1>Update Sport Club Registration</h1>

    <%
        String idStr = request.getParameter("id");
        String name = "", email = "", phone = "", age = "", gender = "", experience = "", sport = "",
               emergencyContactName = "", emergencyContactPhone = "", comments = "";
        Date registrationDate = null;
        String status = "";

        if (idStr != null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");

                int id = Integer.parseInt(idStr);
                String DB_URL = "jdbc:mysql://localhost:3306/student_health_wellness";
                String DB_USER = "root";
                String DB_PASSWORD = "GSK&ydk1";

                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement("SELECT * FROM sport_club_registrations WHERE id=?")) {
                    stmt.setInt(1, id);
                    try (ResultSet rs = stmt.executeQuery()) {
                        if (rs.next()) {
                            name = rs.getString("name");
                            email = rs.getString("email");
                            phone = rs.getString("phone");
                            age = rs.getString("age");
                            gender = rs.getString("gender");
                            experience = rs.getString("experience");
                            sport = rs.getString("sport");
                            emergencyContactName = rs.getString("emergency_contact_name");
                            emergencyContactPhone = rs.getString("emergency_contact_phone");
                            comments = rs.getString("comments");
                            registrationDate = rs.getDate("registration_date");
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
            <h4>Experience Level:</h4>
            <p><%= experience %></p>
        </div>
        <div class="detail">
            <h4>Sport:</h4>
            <p><%= sport %></p>
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
            <h4>Registration Date:</h4>
            <p><%= registrationDate != null ? registrationDate.toString() : "" %></p>
        </div>
        <div class="detail">
            <h4>Status:</h4>
            <p><%= status %></p>
        </div>
    </div>

    <form action="SportServlet" method="post">
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
            <option value="non_binary" <%= "non_binary".equals(gender) ? "selected" : "" %>>Non-Binary</option>
            <option value="prefer_not_to_say" <%= "prefer_not_to_say".equals(gender) ? "selected" : "" %>>Prefer not to say</option>
        </select>

        <label for="experience">Experience Level:</label>
        <select id="experience" name="experience" required>
            <option value="beginner" <%= "beginner".equals(experience) ? "selected" : "" %>>Beginner</option>
            <option value="intermediate" <%= "intermediate".equals(experience) ? "selected" : "" %>>Intermediate</option>
            <option value="advanced" <%= "advanced".equals(experience) ? "selected" : "" %>>Advanced</option>
        </select>

        <label for="sport">Sport Club:</label>
        <input type="text" id="sport" name="sport" value="<%= sport %>" required>
        

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
