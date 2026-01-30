<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Profile</title>
</head>
<body>
<h2>Update Profile</h2>
<form action="/member/update" method="post">
    <input type="hidden" name="id" value="${member.id}"/>
    Name: <input type="text" name="name" value="${member.name}" required/><br/>
    Email: <input type="email" name="email" value="${member.email}" required/><br/>
    Password: <input type="password" name="password" value="${member.password}" required/><br/>
    <input type="submit" value="Update"/>
</form>
<a href="/member/dashboard">Back to Dashboard</a>
</body>
</html>
