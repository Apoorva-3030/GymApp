<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Trainer Form | Gym Management System</title>

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
	background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
	color: #f5f5f5;
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

/* Glass Card Form */
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

.form-label {
	color: #f5f5f5;
	font-weight: 500;
}

.form-control {
	background: rgba(255, 255, 255, 0.12);
	border: 1px solid rgba(255, 184, 0, 0.3);
	color: #f5f5f5;
}

.form-control::placeholder {
	color: #d1d5db;
}

.form-control:focus {
	background: rgba(255, 255, 255, 0.25);
	color: #f5f5f5;
	border-color: #ffb800;
	box-shadow: none;
}

/* Buttons */
.btn-primary, .btn-secondary {
	border-radius: 30px;
	font-weight: 600;
	padding: 8px 25px;
	transition: all 0.3s ease;
}

.btn-primary {
	border-color: #ffb800;
	color: #ffb800;
	background: transparent;
}

.btn-primary:hover {
	background: #ffb800;
	color: #1a1a1a;
}

.btn-secondary {
	border-color: #6c757d;
	color: #d1d5db;
	background: transparent;
}

.btn-secondary:hover {
	background: #6c757d;
	color: #fff;
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
	<nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
		<div class="container">
			<a class="navbar-brand" href="/admin/dashboard">🏋️ Admin
				Dashboard</a> <a href="/logout"
				class="btn btn-outline-light btn-logout btn-sm">Logout</a>
		</div>
	</nav>

	<!-- Form Section -->
	<div class="container my-5">
		<div class="row justify-content-center">
			<div class="col-md-6">

				<div class="glass-card p-4">

					<h3 class="text-center fw-bold mb-4">
						<c:choose>
							<c:when test="${empty trainer.id}">
                            Add Trainer
                        </c:when>
							<c:otherwise>
                            Edit Trainer
                        </c:otherwise>
						</c:choose>
					</h3>

					<form action="/admin/trainers/save" method="post">
						<input type="hidden" name="id" value="${trainer.id}" />

						<!-- Name -->
						<div class="mb-3">
							<label class="form-label">Name</label> <input type="text"
								name="name" class="form-control" value="${trainer.name}"
								placeholder="Enter trainer name" required>
						</div>

						<!-- Email -->
						<div class="mb-3">
							<label class="form-label">Email</label> <input type="email"
								name="email" class="form-control" value="${trainer.email}"
								placeholder="Enter email" required>
						</div>

						<!-- Password -->
						<div class="mb-4">
							<label class="form-label">Password</label> <input type="password"
								name="password" class="form-control" value="${trainer.password}"
								placeholder="Enter password" required>
						</div>

						<!-- Buttons -->
						<div class="d-flex justify-content-between">
							<a href="/admin/trainers" class="btn btn-secondary"> Cancel </a>
							<button type="submit" class="btn btn-primary">Save
								Trainer</button>
						</div>

					</form>

				</div>

			</div>
		</div>
	</div>

	<!-- Footer -->
	<footer class="text-center py-3"> © 2025 Gym Management System
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
