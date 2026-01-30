<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>


<html>
<head>
    <title>Trainers</title>
</head>
<body>
<h1>Trainer List</h1>

<a href="/admin/trainers/add">Add Trainer</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="trainer" items="${trainers}">
        <tr>
            <td>${trainer.id}</td>
            <td>${trainer.name}</td>
            <td>${trainer.email}</td>
            <td>
                <a href="/admin/trainers/edit/${trainer.id}">Edit</a> |
                <a href="/admin/trainers/delete/${trainer.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>
</body>
</html>

