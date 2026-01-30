<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<html>
<head>
    <title>Member Dashboard</title>
</head>
<body>
<h1>Welcome ${member.name}!</h1>

<p>Email: ${member.email}</p>
<p>Trainer: ${member.trainer.name}</p>
<p>Plan: ${member.plan.name}</p>

<a href="/logout">Logout</a>
</body>
</html>
