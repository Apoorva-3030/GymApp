<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="com.gymapp.entity.Trainer" %>
<%@ page import="com.gymapp.entity.Member" %>
<%@ page import="com.gymapp.entity.Plan" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>${member.id != null ? "Edit Member" : "Add Member"}</h2>
<form method="post" action="members/save">
    <input type="hidden" name="id" value="${member.id}" />
    Name: <input type="text" name="name" value="${member.name}"/><br/>
    Email: <input type="text" name="email" value="${member.email}"/><br/>
    Password: <input type="password" name="password" value="${member.password}"/><br/>
    Trainer:
    <select name="trainer.id">
<%
    List<Trainer> trainers = (List<Trainer>) request.getAttribute("trainers");
    Member member = (Member) request.getAttribute("member");

    if (trainers != null) {
        for (Trainer trainer : trainers) {
            boolean selected = false;

            if (member != null && member.getTrainer() != null) {
                if (member.getTrainer().getId().equals(trainer.getId())) {
                    selected = true;
                }
            }
%>
        <option value="<%= trainer.getId() %>" <%= selected ? "selected" : "" %>>
            <%= trainer.getName() %>
        </option>
<%
        }
    }
%>
</select>
    <%-- <select name="trainer.id">
        <c:forEach var="trainer" items="${trainers}">
            <option value="${trainer.id}" ${member.trainer != null && member.trainer.id == trainer.id ? "selected" : ""}>${trainer.name}</option>
        </c:forEach>
    </select> --%><br/>
    Plan:


<select name="plan.id">
<%
    List<Plan> plans = (List<Plan>) request.getAttribute("plans");


    if (plans != null) {
        for (Plan plan : plans) {
            boolean selected = false;

            if (member != null && member.getPlan() != null) {
                if (member.getPlan().getId().equals(plan.getId())) {
                    selected = true;
                }
            }
%>
        <option value="<%= plan.getId() %>" <%= selected ? "selected" : "" %>>
            <%= plan.getName() %>
        </option>
<%
        }
    }
%>
</select>
    
    <%-- <select name="plan.id">
        <c:forEach var="plan" items="${plans}">
            <option value="${plan.id}" ${member.plan != null && member.plan.id == plan.id ? "selected" : ""}>${plan.name}</option>
        </c:forEach>
    </select> --%><br/>
    <input type="submit" value="Save"/>
</form>
<a href="/admin/members">Back to Members</a>

</body>
</html>