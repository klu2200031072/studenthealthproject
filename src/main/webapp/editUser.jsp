<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit User</title>
</head>
<body>
    <h2>Edit User</h2>

    <form action="UserServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="id" value="${user.id}">

        <label for="username">Username:</label>
        <input type="text" id="username" name="username" value="${user.username}" required><br><br>

        <label for="password">Password:</label>
        <input type="password" id="password" name="password" value="${user.password}" required><br><br>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" value="${user.email}" required><br><br>

        <input type="submit" value="Update User">
    </form>
    <br>
    <a href="users.jsp">Back to User List</a>
</body>
</html>
