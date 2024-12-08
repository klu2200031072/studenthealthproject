<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 0;
            padding: 0;
            background-image: url('admin.jpg'); /* Background image */
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #333;
        }

        header {
            background: rgba(0, 77, 0, 0.9);
            color: #fff;
            padding: 15px 0;
            text-align: center;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        nav ul {
            list-style: none;
            padding: 0;
            margin: 10px 0 0;
        }

        nav ul li {
            display: inline;
            margin-right: 15px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: bold;
            transition: color 0.3s;
        }

        nav ul li a:hover {
            color: #ffc107;
            text-decoration: underline;
        }

        main {
            padding: 20px;
            display: flex;
            flex-wrap: wrap;
            justify-content: space-between;
        }

        section {
            margin: 10px; /* Added margin for better spacing */
            padding: 20px;
            background: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
            flex: 1 1 calc(30% - 20px); /* Adjusted for better responsiveness */
            max-width: calc(30% - 20px);
            transition: transform 0.3s;
            display: none; /* Hide sections by default */
        }

        section:hover {
            transform: translateY(-5px);
        }

        section h2 {
            border-bottom: 2px solid #004d00;
            padding-bottom: 5px;
            color: #004d00;
        }

        section p a {
            color: #004d00;
            text-decoration: none;
            padding: 5px 10px;
            border: 1px solid #004d00;
            border-radius: 4px;
            transition: background-color 0.3s, color 0.3s;
        }

        section p a:hover {
            background-color: #004d00;
            color: #fff;
        }

        footer {
            background: rgba(0, 77, 0, 0.9);
            color: #fff;
            text-align: center;
            padding: 15px 0;
            position: relative;
            margin-top: 20px;
        }
    </style>
    <script>
        function toggleSection(sectionId) {
            const sections = document.querySelectorAll('section');
            sections.forEach(section => {
                if (section.id === sectionId) {
                    section.style.display = section.style.display === 'none' ? 'block' : 'none';
                } else {
                    section.style.display = 'none'; // Hide other sections
                }
            });
        }

        window.onload = function() {
            // Hide all sections initially
            const sections = document.querySelectorAll('section');
            sections.forEach(section => {
                section.style.display = 'none';
            });
        };
    </script>
</head>
<body>
    <header>
        <h1>Admin Dashboard</h1>
        <nav>
            <ul>
            
               
                <li><a href="#" onclick="toggleSection('facilities')">Manage Facilities</a></li>
                <li><a href="#" onclick="toggleSection('fitnessClasses')">Manage Fitness Classes</a></li>
                <li><a href="#" onclick="toggleSection('intramural')">Manage Intramural Events</a></li>
                <li><a href="#" onclick="toggleSection('sportClubs')">Manage Sport Clubs</a></li>
                <li><a href="#" onclick="toggleSection('youthCamps')">Manage Youth Camps</a></li>
                
                
                <li><a href="#" onclick="toggleSection('mentalHealth')">Manage Mental Health Services</a></li>
                
                <li><a href="LogoutServlet">Logout</a></li>
                <li><a href="StatisticalReportsServlet">View Statistical Reports</a></li>
            </ul>
        </nav>
    </header>

    <main>
    <section id="Users">
            <h2>Sport Clubs Management</h2>
            <p><a href="UserServlet?action=view">View All  Users</a></p>
            <p><a href="addUser.jsp">Add New User</a></p>
            <p><a href="UserServlet?action=update">Update User</a></p>
            <p><a href="UserServlet?action=delete">Delete User</a></p>
        </section>
        <section id="facilities">
            <h2>Facilities Management</h2>
            <p><a href="FacilitiesServlet?action=view">View All Facilities</a></p>
            <p><a href="addFacility.jsp">Add New Facility</a></p>
            <p><a href="updateFacility.jsp">Update Facility</a></p>
            <p><a href="deleteFacility.jsp">Delete Facility</a></p>
        </section>

        <section id="fitnessClasses">
            <h2>Fitness Class Management</h2>
            <p><a href="FitnessClassServlet?action=view">View All Fitness Classes</a></p>
            <p><a href="addFitness.jsp">Add New Fitness Class</a></p>
            <p><a href="updateFitness.jsp">Update Fitness Class</a></p>
            <p><a href="deleteFitness.jsp">Delete Fitness Class</a></p>
        </section>

        <section id="intramural">
            <h2>Intramural Events Management</h2>
            <p><a href="IntramuralServlet?action=view">View All Intramural Events</a></p>
            <p><a href="addIntramural.jsp">Add New Intramural Event</a></p>
            <p><a href="updateIntramural.jsp">Update Intramural Event</a></p>
            <p><a href="deleteIntramural.jsp">Delete Intramural Event</a></p>
        </section>

        <section id="sportClubs">
            <h2>Sport Clubs Management</h2>
            <p><a href="SportServlet?action=view">View All Sport Clubs</a></p>
            <p><a href="addSport.jsp">Add New Sport Club</a></p>
            <p><a href="updateSport.jsp">Update Sport Club</a></p>
            <p><a href="deleteSport.jsp">Delete Sport Club</a></p>
        </section>

        <section id="youthCamps">
            <h2>Youth Camps Management</h2>
            <p><a href="YouthServlet?action=view">View All Youth Camps</a></p>
            <p><a href="addYouth.jsp">Add New Youth Camp</a></p>
            <p><a href="updateYouth.jsp">Update Youth Camp</a></p>
            <p><a href="deleteYouth.jsp">Delete Youth Camp</a></p>
        </section>

        

        

        <section id="mentalHealth">
            <h2>Mental Health Services Management</h2>
            <p><a href="MentalServlet?action=view">View All Mental Health Services</a></p>
            <p><a href="addcounseling.jsp">Add New Mental Health Service</a></p>
            <p><a href="updatecounseling.jsp">Update Mental Health Service</a></p>
            <p><a href="deletecounseling.jsp">Delete Mental Health Service</a></p>
        </section>
       
    </main>

    <footer>
        <p>&copy; 2024 Student Health and Wellness</p>
    </footer>
</body>
</html>
