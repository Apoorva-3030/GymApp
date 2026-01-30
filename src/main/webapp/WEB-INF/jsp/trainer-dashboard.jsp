<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Trainer Dashboard | Gym Management System</title>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Google Fonts -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
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
	background: rgba(34, 34, 34, 0.95);
	border-bottom: 2px solid rgba(255, 184, 0, 0.6);
	backdrop-filter: blur(8px);
}

.navbar-brand {
	color: #ffb800 !important;
	font-weight: 700;
	letter-spacing: 0.8px;
}

.btn-logout {
	border-radius: 30px;
	font-weight: 500;
	border-color: #ffb800;
	color: #ffb800;
	transition: all 0.3s ease;
}

.btn-logout:hover {
	background: #ffb800;
	color: #1a1a1a;
}

/* Glass Card */
.glass-card {
	background: rgba(60, 60, 60, 0.95);
	backdrop-filter: blur(12px);
	border-radius: 16px;
	border: 1px solid rgba(255, 184, 0, 0.2);
	box-shadow: 0 20px 40px rgba(255, 184, 0, 0.15);
	transition: all 0.3s ease;
}

.glass-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 25px 50px rgba(255, 184, 0, 0.25);
}

/* Table */
.table-custom thead {
	background: rgba(34, 34, 34, 0.9);
	color: #ffb800;
}

.table-custom tbody tr {
	background: #e9ecef; /* light gray rows */
	color: #1a1a1a;
	transition: all 0.3s ease;
}

.table-custom tbody tr:hover {
	background: #ffd966; /* subtle gold hover */
	color: #1a1a1a;
}

/* Headings */
h3, h4 {
	color: #ffb800;
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
	<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">


		<div class="container">
			<span class="navbar-brand">🏋️ Trainer Dashboard</span> <a
				href="/logout" class="btn btn-outline-light btn-logout btn-sm">Logout</a>
		</div>
	</nav>

	<!-- Content -->
	<div class="container my-5">

		<h3 class="fw-bold mb-4">Welcome, ${trainer.name}!</h3>

		<div class="glass-card p-3">
			<h4 class="mb-3">Your Members</h4>

			<div class="table-responsive">
				<table
					class="table table-bordered table-hover align-middle table-custom">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th>Plan</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="m" items="${members}">
							<tr>
								<td>${m.id}</td>
								<td>${m.name}</td>
								<td>${m.email}</td>
								<td>${m.plan.name}</td>
							</tr>
						</c:forEach>

						<c:if test="${empty members}">
							<tr>
								<td colspan="4" class="text-center text-muted">No members
									assigned</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<div class="action-card p-4 text-center h-100">
			<h5>Messages</h5>
			<p class="text-light small">Communicate with Admin</p>
			<a href="${pageContext.request.contextPath}/messages/trainer"
				class="btn btn-warning w-100"> Open Messages </a>
		</div>



		<h5 class="mt-4">Admin Replies</h5>

		<c:forEach var="msg" items="${messages}">
			<c:if
				test="${msg.senderRole == 'TRAINER' && msg.senderId == trainer.id}">

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

	</div>

	<!-- Footer -->
	<footer class="text-center py-3"> © 2025 Gym Management System
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
