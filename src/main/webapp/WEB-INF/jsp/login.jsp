<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>${role}Login | Gym Management System</title>

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
	color: #f0f0f0;
}

/* Navbar */
.custom-navbar {
	background: rgba(0, 0, 0, 0.65);
	backdrop-filter: blur(14px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.navbar-brand {
	font-weight: 600;
	letter-spacing: 0.8px;
	text-transform: uppercase;
	font-size: 0.95rem;
}

/* Login Card */
.glass-card {
	background: rgba(50, 50, 50, 0.85);
	/* slightly lighter than background */
	backdrop-filter: blur(14px);
	border-radius: 18px;
	border: 1px solid rgba(255, 184, 0, 0.2);
	box-shadow: 0 25px 45px rgba(0, 0, 0, 0.4);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.glass-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 30px 50px rgba(255, 184, 0, 0.2);
}

.form-control {
	background: rgba(255, 255, 255, 0.15);
	border: none;
	color: #fff;
}

.form-control::placeholder {
	color: #d1d5db;
}

.form-control:focus {
	background: rgba(255, 255, 255, 0.25);
	box-shadow: none;
	color: #fff;
}

.btn-login {
	border-radius: 30px;
	font-weight: 500;
	padding: 10px;
	background: #ffc107; /* Gold accent */
	border: none;
	color: #000;
}

.btn-login:hover {
	background: #ffb300;
}

.back-link {
	color: #d1d5db;
}

.back-link:hover {
	color: #fff;
}

footer {
	background: rgba(0, 0, 0, 0.65);
	backdrop-filter: blur(10px);
	margin-top: 50px;
}
</style>
</head>

<body>

	<!-- Navbar -->
	<nav class="navbar navbar-dark custom-navbar">
		<div class="container">
			<a class="navbar-brand" href="${pageContext.request.contextPath}/">
				🏋️ Gym Management </a>
		</div>
	</nav>

	<!-- Login Section -->
	<div class="container d-flex justify-content-center align-items-center"
		style="min-height: 85vh;">
		<div class="glass-card p-4" style="width: 100%; max-width: 420px;">

			<h3 class="text-center fw-semibold mb-1">${role}Login</h3>
			<p class="text-center text-light small mb-4">Sign in to continue
				to your dashboard</p>

			<!-- Error Message -->
			<c:if test="${not empty error}">
				<div class="alert alert-danger text-center">${error}</div>
			</c:if>

			<form
				action="${pageContext.request.contextPath}/login/${role.toLowerCase()}"
				method="post">

				<div class="mb-3">
					<label class="form-label small text-light">Email</label> <input
						type="email" name="email" class="form-control"
						placeholder="you@example.com" required>
				</div>

				<div class="mb-3">
					<label class="form-label small text-light">Password</label> <input
						type="password" name="password" class="form-control"
						placeholder="••••••••" required>
				</div>

				<div class="d-grid mt-4">
					<button type="submit" class="btn btn-login">Login</button>
				</div>
			</form>

			<div class="text-center mt-4">
				<a href="${pageContext.request.contextPath}/"
					class="text-decoration-none back-link"> ← Back to Home </a>
			</div>

		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center py-3">
		<small>© 2025 Gym Management System</small>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>













