<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
    <title>${role} Login</title>
</head>
<body>
<h1>${role} Login</h1>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="/login/${role.toLowerCase()}" method="post">
    Email: <input type="email" name="email" required/><br/>
    Password: <input type="password" name="password" required/><br/>
    <button type="submit">Login</button>
</form>

<a href="/">Back to Home</a>
</body>
</html>
