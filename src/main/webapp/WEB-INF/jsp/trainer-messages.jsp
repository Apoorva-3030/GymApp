<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>My Messages | Gym Management</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	color: #f5f5f5;
	min-height: 100vh;
}

.glass-card {
	background: rgba(50, 50, 50, 0.9);
	backdrop-filter: blur(14px);
	border-radius: 18px;
	border: 1px solid rgba(255, 184, 0, 0.25);
	padding: 20px;
	margin-bottom: 20px;
}

.badge-role {
	background: linear-gradient(135deg, #ffc107, #ff9800);
	color: #1a1a1a;
	font-weight: 600;
}
</style>
</head>
<body>

	<div class="container" style="margin-top: 80px; margin-bottom: 60px;">
		<h3 class="fw-semibold mb-4">My Messages</h3>

		<!-- Send new message -->
		<div class="glass-card mb-4">
			<form method="post"
				action="${pageContext.request.contextPath}/messages/send">
				<textarea name="message" class="form-control mb-2" rows="3"
					placeholder="Send message to admin..." required></textarea>
				<button class="btn btn-warning btn-sm px-4">Send</button>
			</form>
		</div>

		<!-- Messages list -->
		<c:forEach var="msg" items="${messages}">
			<div class="glass-card">
				<div class="d-flex justify-content-between mb-2">
					<strong>Admin Reply</strong> <span class="badge bg-success">${msg.adminReply != null ? 'Replied' : 'Pending'}</span>
				</div>
				<p class="text-light mb-1">
					<strong>Your Message:</strong> ${msg.message}
				</p>
				<p class="text-warning mb-0">
					<strong>Reply:</strong>
					<c:choose>
						<c:when test="${not empty msg.adminReply}">
                        ${msg.adminReply}
                    </c:when>
						<c:otherwise>
                        Not replied yet
                    </c:otherwise>
					</c:choose>
				</p>
			</div>
		</c:forEach>
	</div>
	<div class="container" style="margin-top: 80px; margin-bottom: 60px;">

		<!-- Back to Dashboard -->
		<div class="mb-4">
			<a href="/trainer/dashboard" class="btn btn-outline-light btn-sm">
				← Back to Dashboard </a>
		</div>
		<script
			src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
