<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>${trainer.id != null ? "Edit Trainer" : "Add Trainer"}</h2>
<form method="post" action="save">
    <input type="hidden" name="id" value="${trainer.id}" />
    Name: <input type="text" name="name" value="${trainer.name}"/><br/>
    Email: <input type="text" name="email" value="${trainer.email}"/><br/>
    Password: <input type="password" name="password" value="${trainer.password}"/><br/>
    <input type="submit" value="Save"/>
</form>
<a href="/admin/trainers">Back to Trainers</a>

</body>
</html>