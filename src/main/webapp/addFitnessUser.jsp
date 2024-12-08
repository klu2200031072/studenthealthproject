<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Fitness Class Registration</title>
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
        input[type="number"],
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
        p {
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <h1>Add Fitness Class Registration</h1>
    <form action="FitnessClassServletUser" method="post">
        <input type="hidden" name="action" value="create">
        
        <label for="name">Your Name:</label>
        <input type="text" id="name" name="name" required>
        
        <label for="email">Email Address:</label>
        <input type="email" id="email" name="email" required>
        
        <label for="phone">Phone Number:</label>
        <input type="text" id="phone" name="phone" required>
        
        <label for="age">Age:</label>
        <input type="number" id="age" name="age" required>
        
        <label for="gender">Gender:</label>
        <select id="gender" name="gender" required>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="non_binary">Non-binary</option>
            <option value="prefer_not_to_say">Prefer not to say</option>
        </select>
        
        <label for="fitness_class">Fitness Class:</label>
        <select id="fitness_class" name="fitness_class" required>
            <option value="cycling">Cycling</option>
            <option value="yoga">Yoga</option>
            <option value="barre">Barre</option>
            <option value="kickboxing">Kickboxing</option>
            <option value="cross_training">Cross Training</option>
            <option value="hiit">HIIT</option>
        </select>
        
        <label for="training_type">Training Type:</label>
        <select id="training_type" name="training_type" required>
            <option value="personal">Personal</option>
            <option value="group">Group</option>
        </select>
        
        <label for="experience">Experience Level:</label>
        <select id="experience" name="experience" required>
            <option value="beginner">Beginner</option>
            <option value="intermediate">Intermediate</option>
            <option value="advanced">Advanced</option>
        </select>
        
        <label for="emergency_contact_name">Emergency Contact Name:</label>
        <input type="text" id="emergency_contact_name" name="emergency_contact_name" required>
        
        <label for="emergency_contact_phone">Emergency Contact Phone:</label>
        <input type="text" id="emergency_contact_phone" name="emergency_contact_phone" required>
        
        <label for="comments">Additional Comments:</label>
        <textarea id="comments" name="comments" rows="4"></textarea>
        
        <label for="registration_date">Registration Date:</label>
        <input type="date" id="registration_date" name="registration_date" required>
        
        <input type="submit" value="Register for Fitness Class">
    </form>
    
</body>
</html>
