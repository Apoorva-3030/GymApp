<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h2>${plan.id != null ? "Edit Plan" : "Add Plan"}</h2>
<form method="post" action="plans/save">
    <input type="hidden" name="id" value="${plan.id}" />
    Name: <input type="text" name="name" value="${plan.name}"/><br/>
    Price: <input type="number" step="0.01" name="price" value="${plan.price}"/><br/>
    Duration (Months): <input type="number" name="durationMonths" value="${plan.durationMonths}"/><br/>
    <input type="submit" value="Save"/>
</form>
<a href="/admin/plans">Back to Plans</a>

</body>
</html>