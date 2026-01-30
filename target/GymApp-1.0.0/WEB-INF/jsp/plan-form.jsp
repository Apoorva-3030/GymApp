<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
    <title>Plan Form</title>
</head>
<body>
<h1>Plan Form</h1>

<form action="/admin/plans/save" method="post">
    <input type="hidden" name="id" value="${plan.id}"/>
    Name: <input type="text" name="name" value="${plan.name}" required/><br/>
    Duration (months): <input type="number" name="duration" value="${plan.duration}" required/><br/>
    Price: <input type="number" step="0.01" name="price" value="${plan.price}" required/><br/>
    <button type="submit">Save</button>
</form>

<a href="/admin/plans">Back to List</a>
</body>
</html>
