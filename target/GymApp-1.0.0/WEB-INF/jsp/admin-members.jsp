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
<h2>Members</h2>
<a href="members/new">Add New Member</a>
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
            <td>${member.trainer != null ? member.trainer.name : ""}</td>
            <td>${member.plan != null ? member.plan.name : ""}</td>
            <td>
                <a href="members/edit/${member.id}">Edit</a> | 
                <a href="members/delete/${member.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>

</body>
</html>