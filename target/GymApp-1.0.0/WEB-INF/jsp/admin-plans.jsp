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
<h2>Plans</h2>
<a href="plans/new">Add New Plan</a>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Price</th>
        <th>Duration (Months)</th>
        <th>Actions</th>
    </tr>
    <c:forEach var="plan" items="${plans}">
        <tr>
            <td>${plan.id}</td>
            <td>${plan.name}</td>
            <td>${plan.price}</td>
            <td>${plan.durationMonths}</td>
            <td>
                <a href="plans/edit/${plan.id}">Edit</a> | 
                <a href="plans/delete/${plan.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/dashboard">Back to Dashboard</a>

</body>
</html>