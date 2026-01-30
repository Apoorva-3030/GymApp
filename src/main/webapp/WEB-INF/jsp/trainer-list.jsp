<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Trainers | Gym Management System</title>

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

/* Card / Table */
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
.table thead {
	background: rgba(34, 34, 34, 0.95);
	color: #ffb800;
}

.table tbody tr {
	background: rgba(60, 60, 60, 0.85);
	color: #f5f5f5;
	transition: all 0.3s ease;
}

.table tbody tr:hover {
	background: rgba(75, 75, 75, 0.95);
}

.btn-custom {
	border-radius: 30px;
	font-weight: 600;
	border-color: #ffb800;
	color: #ffb800;
	transition: all 0.3s ease;
}

.btn-custom:hover {
	background: #ffb800;
	color: #1a1a1a;
}

.btn-warning {
	background: #ffb800;
	border-color: #ffb800;
	color: #1a1a1a;
}

.btn-warning:hover {
	background: #e0a800;
	color: #1a1a1a;
}

.btn-danger {
	background: #dc3545;
	border-color: #dc3545;
}

.btn-danger:hover {
	background: #c82333;
}

a.back-link {
	color: #d1d5db;
	text-decoration: none;
}

a.back-link:hover {
	color: #ffb800;
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

	<!-- Content -->
	<div class="container my-5">

		<div class="d-flex justify-content-between align-items-center mb-4">
			<h2 class="fw-bold">Trainers List</h2>
			<div>
				<a href="/admin/trainers/add" class="btn btn-primary me-2">+ Add
					Trainer</a> <a href="/admin/export/trainers/pdf"
					class="btn btn-danger me-1">Export PDF</a> <a
					href="/admin/export/trainers/excel" class="btn btn-success">Export
					Excel</a>
			</div>
		</div>

		<div class="glass-card p-3">
			<div class="table-responsive">
				<table class="table table-bordered table-hover align-middle mb-0">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th class="text-center">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="trainer" items="${trainers}">
							<tr>
								<td>${trainer.id}</td>
								<td>${trainer.name}</td>
								<td>${trainer.email}</td>
								<td class="text-center"><a
									href="/admin/trainers/edit/${trainer.id}"
									class="btn btn-sm btn-warning me-1"> Edit </a> <a
									href="/admin/trainers/delete/${trainer.id}"
									class="btn btn-sm btn-danger"
									onclick="return confirm('Are you sure you want to delete this trainer?');">
										Delete </a></td>
							</tr>
						</c:forEach>

						<c:if test="${empty trainers}">
							<tr>
								<td colspan="4" class="text-center text-muted">No trainers
									found</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>

		<div class="mt-3">
			<a href="/admin/dashboard" class="back-link"> ← Back to Dashboard
			</a>
		</div>

	</div>

	<!-- Footer -->
	<footer class="text-center py-3"> © 2025 Gym Management System
	</footer>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
