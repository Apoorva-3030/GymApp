<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Dashboard | Gym Management System</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #1c1c1c, #2a2a2a);
	/* dark charcoal gradient */
	min-height: 100vh;
}

/* Navbar */
.custom-navbar {
	background: rgba(34, 34, 34, 0.95); /* deep charcoal navbar */
	backdrop-filter: blur(8px);
	border-bottom: 2px solid rgba(255, 184, 0, 0.5); /* gold accent */
}

.navbar-brand {
	color: #ffb800 !important; /* gold accent text */
	font-weight: 700;
	letter-spacing: 0.5px;
}

/* Card */
.glass-card {
	background: rgba(40, 40, 40, 0.9); /* slightly lighter charcoal */
	backdrop-filter: blur(12px);
	border-radius: 16px;
	border: 1px solid rgba(255, 184, 0, 0.4); /* subtle gold border */
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.5);
	color: #f5f5f5; /* light text for readability */
}

/* List Items */
.list-group-item {
	background: transparent;
	color: #f5f5f5;
	border-color: rgba(255, 184, 0, 0.25);
	font-weight: 500;
}

/* Accent labels */
.label {
	font-size: 0.85rem;
	color: #ffb800; /* gold accent */
	font-weight: 600;
}

/* Expired date */
.expired {
	color: #e63946; /* red for expired plans */
	font-weight: 700;
}

/* Buttons */
.btn-outline-light {
	border-color: #ffb800;
	color: #ffb800;
	font-weight: 600;
}

.btn-outline-light:hover {
	background: #ffb800;
	color: #1c1c1c; /* match background for hover contrast */
}

/* Footer */
footer {
	background: rgba(34, 34, 34, 0.95);
	border-top: 1px solid rgba(255, 184, 0, 0.35);
	color: #f5f5f5;
	font-weight: 600;
}

.position-relative {
	position: relative !important;
}

.badge {
	font-size: 0.8rem;
	padding: 0.4em 0.6em;
	color: #fff;
}
</style>
</head>

<body>

	<!-- Navbar -->
	<nav class="navbar navbar-dark custom-navbar">



		<div class="container">
			<span class="navbar-brand">🏋️ Member Dashboard</span> <a
				href="/logout" class="btn btn-outline-light btn-sm"> Logout </a>
		</div>

	</nav>
	<div class="action-card p-4 text-center h-100">
		<h5>Messages</h5>
		<p class="text-light small">Communicate with Admin</p>
		<a href="${pageContext.request.contextPath}/messages/member"
			class="btn btn-warning w-100"> Open Messages </a>
	</div>
	<!-- Content -->
	<div class="container d-flex justify-content-center align-items-center"
		style="min-height: 85vh;">
		<div class="glass-card p-4" style="max-width: 460px; width: 100%;">

			<h3 class="text-center fw-semibold mb-4">Welcome, ${member.name}
				👋</h3>

			<ul class="list-group list-group-flush">

				<li class="list-group-item"><span class="label">Email</span><br>
					${member.email}</li>

				<li class="list-group-item"><span class="label">Trainer</span><br>
					${member.trainer.name}</li>

				<li class="list-group-item"><span class="label">Plan</span><br>
					${member.plan.name}</li>

				<li class="list-group-item"><span class="label">Plan
						Expiry Date</span><br> <c:set var="today"
						value="<%= java.time.LocalDate.now() %>" /> <c:choose>
						<c:when test="${not empty member.planExpiryDate}">
							<c:choose>
								<c:when test="${member.planExpiryDate lt today}">
									<span class="expired"> ${member.planExpiryDate}
										(Expired) </span>
								</c:when>
								<c:otherwise>
                                ${member.planExpiryDate}
                            </c:otherwise>
							</c:choose>
						</c:when>
						<c:otherwise>
                        N/A
                    </c:otherwise>
					</c:choose></li>

			</ul>

		</div>
	</div>





	<h5 class="mt-4">Admin Replies</h5>

	<c:forEach var="msg" items="${messages}">
		<c:if
			test="${msg.senderRole == 'MEMBER' && msg.senderId == member.id}">

			<div class="border p-3 mb-2 rounded">
				<p>
					<strong>You:</strong> ${msg.message}
				</p>

				<c:choose>
					<c:when test="${not empty msg.adminReply}">
						<p class="text-success">
							<strong>Admin:</strong> ${msg.adminReply}
						</p>
					</c:when>
					<c:otherwise>
						<p class="text-muted">Waiting for reply...</p>
					</c:otherwise>
				</c:choose>
			</div>
		</c:if>
	</c:forEach>




	<!-- Footer -->
	<footer class="text-center text-white py-3">
		<small>© 2025 Gym Management System</small>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>















