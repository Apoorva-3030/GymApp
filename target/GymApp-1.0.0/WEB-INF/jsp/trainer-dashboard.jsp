<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html>
<head>
    <title>Trainer Dashboard</title>
</head>
<body>
<h1>Welcome Trainer!</h1>

<h2>Your Members:</h2>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Plan</th>
    </tr>
    <c:forEach var="m" items="${members}">
        <tr>
            <td>${m.id}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>${m.plan.name}</td>
        </tr>
    </c:forEach>
</table>

<a href="/logout">Logout</a>
</body>
</html>

