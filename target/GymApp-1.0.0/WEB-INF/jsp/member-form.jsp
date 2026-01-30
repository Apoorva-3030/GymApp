<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Member Form</title>
</head>
<body>
<h1>Member Form</h1>

<form action="/admin/members/save" method="post">
    <input type="hidden" name="id" value="${member.id}"/>
    Name: <input type="text" name="name" value="${member.name}" required/><br/>
    Email: <input type="email" name="email" value="${member.email}" required/><br/>
    Password: <input type="password" name="password" value="${member.password}" required/><br/>

    Trainer:
    <select name="trainer.id" required>
        <c:forEach var="t" items="${trainers}">
            <option value="${t.id}" <c:if test="${member.trainer.id == t.id}">selected</c:if>>${t.name}</option>
        </c:forEach>
    </select><br/>

    Plan:
    <select name="plan.id" required>
        <c:forEach var="p" items="${plans}">
            <option value="${p.id}" <c:if test="${member.plan.id == p.id}">selected</c:if>>${p.name}</option>
        </c:forEach>
    </select><br/>

    <button type="submit">Save</button>
</form>

<a href="/admin/members">Back to List</a>
</body>
</html>
