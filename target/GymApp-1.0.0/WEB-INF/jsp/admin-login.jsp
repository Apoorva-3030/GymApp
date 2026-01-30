<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<h1>Admin Login</h1>
<form method="post" action="/admin/login">
    Email: <input type="text" name="email"/><br/>
    Password: <input type="password" name="password"/><br/>
    <input type="submit" value="Login"/>
</form>
<a href="/">Back to Home</a>
