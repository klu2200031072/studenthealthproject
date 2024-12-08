<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fit&Well - Register for Event</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        /* Center the main content */
        body {
            display: flex;
            flex-direction: column;
            align-items: center; /* Center horizontally */
            justify-content: center; /* Center vertically */
            height: 100vh; /* Full viewport height */
            margin: 0; /* Remove default margin */
            text-align: center; /* Center text */
        }
        /* Style for the message text */
        .registration-message {
            color: green; /* Change the text color to green */
        }
        /* Style for the header */
        header {
            margin-bottom: 20px; /* Space between header and main content */
        }
    </style>
</head>
<body>
    <header>
        <h2>Fit&Well Event Registration</h2>
    </header>

    <main>
        <h3>Registration Result</h3>
        <p class="registration-message">
            <%
                String event = request.getParameter("event");
                String message = "";
                if (event != null) {
                    // Process the registration logic here
                    // Example: Store the registration in a database or a list
                    // Here, we're just simulating the registration success
                    message = "You have successfully registered for the event: " + event + ".";
                } else {
                    message = "No event selected.";
                }
            %>
            <%= message %>
        </p>
        <p><a href="event.jsp">Back to Event Calendar</a></p>
    </main>
</body>
</html>
