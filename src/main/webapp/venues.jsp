<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Venues</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            line-height: 1.6;
        }
        h1 {
            text-align: center;
            color: #004d00;
        }
        .venue-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            margin-top: 20px;
        }
        .venue-card {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            width: 300px;
            padding: 20px;
            text-align: center;
        }
        .venue-card img {
            width: 100%;
            border-radius: 8px;
            margin-bottom: 15px;
        }
        .venue-card h3 {
            color: #004d00;
            font-size: 20px;
        }
        .venue-card p {
            font-size: 16px;
            color: #555;
        }
        a.back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            color: #004d00;
            text-decoration: none;
            font-weight: bold;
        }
        a.back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h1>Available Venues</h1>
    <div class="venue-container">
        <!-- Venue for Gym -->
        <div class="venue-card">
            <img src="images/gym.jpg" alt="Gym">
            <h3>Gym</h3>
            <p><strong>Location:</strong> Recreation Center, Building A, Level 2</p>
            <p><strong>Timings:</strong> 6:00 AM - 10:00 PM</p>
            <p><strong>Features:</strong> Cardio equipment, free weights, weightlifting machines.</p>
        </div>

        <!-- Venue for Pool -->
        <div class="venue-card">
            <img src="images/pool.jpg" alt="Swimming Pool">
            <h3>Swimming Pool</h3>
            <p><strong>Location:</strong> Recreation Center, Building B</p>
            <p><strong>Timings:</strong> 8:00 AM - 8:00 PM</p>
            <p><strong>Features:</strong> Olympic-sized pool with heated water and diving sections.</p>
        </div>

        <!-- Venue for Tennis Court -->
        <div class="venue-card">
            <img src="images/tennis-court.jpg" alt="Tennis Court">
            <h3>Tennis Court</h3>
            <p><strong>Location:</strong> Outdoor Sports Complex, Court 3 & 4</p>
            <p><strong>Timings:</strong> 7:00 AM - 9:00 PM</p>
            <p><strong>Features:</strong> Professional-grade courts with night lighting.</p>
        </div>

        <!-- Venue for Basketball Court -->
        <div class="venue-card">
            <img src="images/basketball.jpg" alt="Basketball Court">
            <h3>Basketball Court</h3>
            <p><strong>Location:</strong> Indoor Sports Hall, Court 2</p>
            <p><strong>Timings:</strong> 9:00 AM - 9:00 PM</p>
            <p><strong>Features:</strong> Hardwood flooring, full-sized court with electronic scoreboard.</p>
        </div>
    </div>
    <a href="admindashboard.jsp" class="back-link">Back to Dashboard</a>
</body>
</html>
