<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>

<html>
<head>
    <title>Trainer Form</title>
</head>
<body>
<h1>Trainer Form</h1>

<form action="/admin/trainers/save" method="post">
    <input type="hidden" name="id" value="${trainer.id}"/>
    Name: <input type="text" name="name" value="${trainer.name}" required/><br/>
    Email: <input type="email" name="email" value="${trainer.email}" required/><br/>
    Password: <input type="password" name="password" value="${trainer.password}" required/><br/>
    <button type="submit">Save</button>
</form>

<a href="/admin/trainers">Back to List</a>
</body>
</html>

