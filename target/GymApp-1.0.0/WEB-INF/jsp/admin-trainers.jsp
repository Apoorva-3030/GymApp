<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>Trainers</h2>
<a href="trainers/new">Add New Trainer</a>
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
                <a href="trainers/edit/${trainer.id}">Edit</a> | 
                <a href="trainers/delete/${trainer.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>

</body>
</html>