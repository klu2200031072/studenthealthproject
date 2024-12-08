<html>
<head>
    <title>Users List</title>
</head>
<body>
    <h2>Users List</h2>
    <a href="addUser.jsp">Add User</a>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Actions</th>
        </tr>
        <!-- The following section can be populated dynamically using JSP scriptlets or JSTL -->
        <tr>
            <td>1</td>
            <td>SampleUser</td>
            <td>sampleuser@example.com</td>
            <td>
                <a href="UserServlet?action=edit&id=1">Edit</a> |
                <a href="UserServlet?action=delete&id=1">Delete</a>
            </td>
        </tr>
        <!-- Repeat for other users -->
    </table>
</body>
</html>
