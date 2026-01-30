<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<html>
<head>
    <title>Members</title>
</head>
<body>
<h1>Member List</h1>

<a href="/admin/members/add">Add Member</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Trainer</th>
        <th>Plan</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="member" items="${members}">
        <tr>
            <td>${member.id}</td>
            <td>${member.name}</td>
            <td>${member.email}</td>
            <td>${member.trainer.name}</td>
            <td>${member.plan.name}</td>
            <td>
                <a href="/admin/members/edit/${member.id}">Edit</a> |
                <a href="/admin/members/delete/${member.id}">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>
</body>
</html>
