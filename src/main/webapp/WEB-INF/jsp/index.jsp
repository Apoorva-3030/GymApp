<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Gym Management System</title>

<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Google Font -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
	rel="stylesheet">

<style>
/* Body */
body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, #1a1a1a, #2c2c2c, #3d3d3d);
	/* dark gym gradient */
	min-height: 100vh;
	color: #f5f5f5;
}

/* Navbar */
.custom-navbar {
	background: rgba(34, 34, 34, 0.95);
	border-bottom: 2px solid rgba(255, 184, 0, 0.6); /* gold accent */
	backdrop-filter: blur(8px);
}

.navbar-brand {
	color: #ffb800 !important; /* gold accent */
	font-weight: 700;
	letter-spacing: 0.8px;
}

/* Hero Section */
.hero {
	padding: 100px 0 60px;
	text-align: center;
}

.hero h1 {
	font-weight: 700;
	letter-spacing: 1px;
	color: #ffb800; /* gold headline */
}

.hero p {
	color: #d1d5db; /* lighter grey text */
	max-width: 650px;
	margin: auto;
	font-weight: 500;
}

/* Cards */
.glass-card {
	background: rgba(60, 60, 60, 0.95);
	/* slightly lighter than background */
	border-radius: 16px;
	backdrop-filter: blur(12px);
	border: 1px solid rgba(255, 184, 0, 0.2); /* subtle gold border */
	transition: all 0.4s ease;
	color: #f5f5f5;
}

.glass-card:hover {
	transform: translateY(-6px);
	box-shadow: 0 20px 40px rgba(255, 184, 0, 0.25);
	background: rgba(65, 65, 65, 0.95); /* slightly brighter on hover */
}

/* Role Icons */
.role-icon {
	font-size: 3rem;
	color: #ffb800; /* gold accent */
	margin-bottom: 15px;
}

/* Buttons */
.btn-custom {
	border-radius: 30px;
	padding: 10px 25px;
	font-weight: 600;
	border-color: #ffb800;
	color: #ffb800;
	transition: all 0.3s ease;
}

.btn-custom:hover {
	background: #ffb800;
	color: #1a1a1a;
}

/* Footer */
footer {
	background: rgba(34, 34, 34, 0.95);
	border-top: 1px solid rgba(255, 184, 0, 0.35);
	color: #f5f5f5;
	font-weight: 600;
}
</style>
</head>

<body>

	<!-- Navbar -->
	<nav
		class="navbar navbar-expand-lg navbar-dark fixed-top custom-navbar">
		<div class="container">
			<a class="navbar-brand d-flex align-items-center gap-2" href="#">
				<span class="logo-icon">🏋️</span> <span class="logo-text">Gym
					Management</span>
			</a>
		</div>
	</nav>

	<!-- Hero Section -->
	<section class="hero">
		<div class="container">
			<h1 class="mb-3">Gym Management</h1>
			<p class="mb-5">A modern platform to manage members, trainers,
				and fitness plans with efficiency and style.</p>

			<div class="row g-4 justify-content-center">

				<!-- Admin -->
				<div class="col-md-4">
					<div class="glass-card p-4 h-100 text-center">
						<div class="role-icon">🛡️</div>
						<h5 class="fw-semibold mb-2">Administrator</h5>
						<p class="text-light small mb-4">Control operations, manage
							trainers, members and plans.</p>
						<a href="${pageContext.request.contextPath}/login/admin"
							class="btn btn-custom w-100"> Admin Login </a>
					</div>
				</div>

				<!-- Trainer -->
				<div class="col-md-4">
					<div class="glass-card p-4 h-100 text-center">
						<div class="role-icon">💪</div>
						<h5 class="fw-semibold mb-2">Trainer</h5>
						<p class="text-light small mb-4">Track assigned members and
							plans.</p>
						<a href="${pageContext.request.contextPath}/login/trainer"
							class="btn btn-custom w-100"> Trainer Login </a>
					</div>
				</div>

				<!-- Member -->
				<div class="col-md-4">
					<div class="glass-card p-4 h-100 text-center">
						<div class="role-icon">👤</div>
						<h5 class="fw-semibold mb-2">Member</h5>
						<p class="text-light small mb-4">View assigned trainer and
							fitness plans.</p>
						<a href="${pageContext.request.contextPath}/login/member"
							class="btn btn-custom w-100"> Member Login </a>
					</div>
				</div>

			</div>
		</div>
	</section>

	<!-- Footer -->
	<footer class="text-center py-3">
		<small>© 2025 Gym Management System. All rights reserved.</small>
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


