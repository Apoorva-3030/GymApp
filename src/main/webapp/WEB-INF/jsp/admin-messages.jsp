<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Messages | Gym Management</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	min-height: 100vh;
	color: #f5f5f5;
}

/* Navbar */
.custom-navbar {
	background: rgba(0, 0, 0, 0.75);
	backdrop-filter: blur(12px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

/* Glass Card */
.glass-card {
	background: rgba(50, 50, 50, 0.9);
	backdrop-filter: blur(14px);
	border-radius: 18px;
	border: 1px solid rgba(255, 184, 0, 0.25);
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.4);
}

.badge-role {
	background: linear-gradient(135deg, #ffc107, #ff9800);
	color: #1a1a1a;
	font-weight: 600;
}

textarea {
	resize: none;
}

footer {
	background: rgba(0, 0, 0, 0.65);
	backdrop-filter: blur(10px);
}
</style>
</head>

<body>

	<!-- Navbar -->
	<nav class="navbar navbar-dark custom-navbar fixed-top">
		<div class="container">
			<span class="navbar-brand fw-semibold">📩 Admin Messages</span> <a
				href="${pageContext.request.contextPath}/admin/dashboard"
				class="btn btn-outline-light btn-sm"> ← Dashboard </a>
		</div>
	</nav>

	<!-- Content -->
	<div class="container" style="margin-top: 100px; margin-bottom: 60px;">

		<h3 class="fw-semibold mb-4">Inbox</h3>

		<c:if test="${empty messages}">
			<div class="glass-card p-4 text-center text-muted">No messages
				received yet.</div>
		</c:if>

		<c:forEach var="msg" items="${messages}">
			<div class="glass-card p-4 mb-4">

				<!-- Header -->
				<div class="d-flex justify-content-between align-items-center mb-2">
					<div>
						<span class="badge badge-role me-2">${msg.senderRole}</span> <strong>${msg.senderName}</strong>
					</div>

					<c:choose>
						<c:when test="${empty msg.adminReply}">
							<span class="badge bg-warning text-dark">Pending</span>
						</c:when>
						<c:otherwise>
							<span class="badge bg-success">Replied</span>
						</c:otherwise>
					</c:choose>
				</div>

				<!-- Message -->
				<p class="mb-3 text-light">${msg.message}</p>

				<small class="text-warning"> Sent on: ${msg.sentAt} </small>

				<hr class="border-secondary">

				<!-- Reply Section -->
				<c:choose>
					<c:when test="${not empty msg.adminReply}">
						<div class="mt-3">
							<p class="text-success fw-semibold mb-1">Admin Reply</p>
							<p class="mb-0">${msg.adminReply}</p>
							<small class="text-muted">Replied on: ${msg.repliedAt}</small>
						</div>
					</c:when>

					<c:otherwise>
						<form method="post"
							action="${pageContext.request.contextPath}/admin/messages/reply"
							class="mt-3">

							<input type="hidden" name="messageId" value="${msg.id}">

							<textarea name="reply" class="form-control mb-2" rows="3"
								placeholder="Type your reply here..." required></textarea>

							<button class="btn btn-success btn-sm px-4">Send Reply</button>
						</form>
					</c:otherwise>
				</c:choose>
			</div>
		</c:forEach>

	</div>

	<!-- Footer -->
	<footer class="text-center py-3 text-light">
		<small>© 2025 Gym Management System</small>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
