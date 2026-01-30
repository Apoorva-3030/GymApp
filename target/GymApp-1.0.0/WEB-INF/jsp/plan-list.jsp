<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<html>
<head>
    <title>Plans</title>
</head>
<body>
<h1>Plan List</h1>

<a href="/admin/plans/add">Add Plan</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Duration (months)</th>
        <th>Price</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="plan" items="${plans}">
        <tr>
            <td>${plan.id}</td>
            <td>${plan.name}</td>
            <td>${plan.duration}</td>
            <td>${plan.price}</td>
            <td>
                <a href="/admin/plans/edit/${plan.id}">Edit</a> |
                <a href="/admin/plans/delete/${plan.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>
</body>
</html>
