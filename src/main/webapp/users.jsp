<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users</title>
</head>
<body>
    <h2>Users List</h2>

    <c:if test="${param.success == 'created'}">
        <p style="color: green;">User created successfully!</p>
    </c:if>
    <c:if test="${param.success == 'updated'}">
        <p style="color: green;">User updated successfully!</p>
    </c:if>
    <c:if test="${param.success == 'deleted'}">
        <p style="color: red;">User deleted successfully!</p>
    </c:if>

    <a href="addUser.jsp">Add New User</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <c:forEach var="user" items="${users}">
            <tr>
                <td>${user.id}</td>
                <td>${user.username}</td>
                <td>${user.email}</td>
                <td>
                    <a href="editUser.jsp?id=${user.id}">Edit</a> |
                    <a href="UserServlet?action=delete&id=${user.id}">Delete</a>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
