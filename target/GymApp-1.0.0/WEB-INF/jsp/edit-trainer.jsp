<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add/Edit Trainer</title>
</head>
<body>
<h2>Trainer Form</h2>
<form action="${trainer.id != null ? 'edit-trainer' : 'add-trainer'}" method="post">
    <input type="hidden" name="id" value="${trainer.id}"/>
    Name: <input type="text" name="name" value="${trainer.name}" required/><br/>
    Email: <input type="email" name="email" value="${trainer.email}" required/><br/>
    Password: <input type="password" name="password" value="${trainer.password}" required/><br/>
    <input type="submit" value="Save"/>
</form>
<a href="/admin/trainers">Back to Trainers</a>
</body>
</html>
