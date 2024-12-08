<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sport Club Registration</title>
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
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="email"],
        input[type="tel"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        button[type="submit"] {
            background: #004d00;
            color: #fff;
            border: none;
            padding: 10px 15px;
            cursor: pointer;
            border-radius: 5px;
            font-weight: bold;
        }
        button[type="submit"]:hover {
            background: #005700;
        }
        p {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Sport Club Registration</h1>
    <section>
        <h2>Register for a Sport Club</h2>
        
        <form action="SportServlet" method="post" class="reservation-form">
            <div class="centered-container">
                <h1>Join a Sport Club</h1>

                <label for="name">Your Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="email">Email Address:</label>
                <input type="email" id="email" name="email" required>

                <label for="phone">Phone Number:</label>
                <input type="tel" id="phone" name="phone" required>

                <label for="age">Age:</label>
                <input type="number" id="age" name="age" min="1" required>

                <label for="gender">Gender:</label>
                <select id="gender" name="gender" required>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                    <option value="non_binary">Non-Binary</option>
                    <option value="prefer_not_to_say">Prefer not to say</option>
                </select>

                <label for="experience">Experience Level:</label>
                <select id="experience" name="experience" required>
                    <option value="beginner">Beginner</option>
                    <option value="intermediate">Intermediate</option>
                    <option value="advanced">Advanced</option>
                </select>

                <label for="sport">Select Sport Club:</label>
                <select id="sport" name="sport" required>
                    <option value="archery">Archery Club</option>
                    <option value="badminton">Badminton Club</option>
                    <option value="baseball">Baseball Club</option>
                    <option value="basketball">Basketball Club (Men & Women)</option>
                    <option value="bowling">Bowling Club</option>
                    <option value="boxing">Boxing Club</option>
                    <option value="cricket">Cricket Club</option>
                    <option value="equestrian_hunt">Equestrian Club (Hunt)</option>
                    <option value="equestrian_western">Equestrian Club (Western)</option>
                    <option value="fencing">Fencing Club</option>
                    <option value="fishing">Fishing Club</option>
                    <option value="gaming_esports">Gaming and Esports Club</option>
                    <option value="golf">Golf Club</option>
                    <option value="hockey">Hockey Club (Men & Women)</option>
                    <option value="kendo">Kendo Club</option>
                    <option value="lacrosse">Lacrosse Club (Men & Women)</option>
                    <option value="martial_arts">Martial Arts Club</option>
                    <option value="climbing">Climbing Club</option>
                    <option value="rodeo">Rodeo Club</option>
                    <option value="rugby">Rugby Club (Men & Women)</option>
                    <option value="running">Running Club</option>
                    <option value="soccer">Soccer Club (Men & Women)</option>
                    <option value="softball">Softball Club</option>
                    <option value="swim">Swim Club</option>
                    <option value="table_tennis">Table Tennis Club</option>
                    <option value="tennis">Tennis Club</option>
                    <option value="triathlon">Triathlon Club</option>
                    <option value="ultimate_frisbee">Ultimate Frisbee Club (Men & Women)</option>
                    <option value="volleyball">Volleyball Club (Men & Women)</option>
                    <option value="water_polo">Water Polo Club</option>
                    <option value="weight">Weight Club</option>
                    <option value="wrestling">Wrestling Club</option>
                </select>

                <label for="emergency_contact_name">Emergency Contact Name:</label>
                <input type="text" id="emergency_contact_name" name="emergency_contact_name" required>

                <label for="emergency_contact_phone">Emergency Contact Phone Number:</label>
                <input type="tel" id="emergency_contact_phone" name="emergency_contact_phone" required>

                <label for="comments">Additional Comments:</label>
                <textarea id="comments" name="comments" rows="4"></textarea>

                <button type="submit">Register</button>
            </div>
        </form>
    </section>
    <p><a href='admindashboard.jsp'>Back to Dashboard</a></p>
</body>
</html>
