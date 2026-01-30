<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Admin Dashboard | Gym Management System</title>

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

.logout-btn {
	border-radius: 30px;
	padding: 6px 18px;
}

/* Dashboard */
.dashboard-container {
	margin-top: 90px;
}

/* Stat Cards */
.stat-card {
	background: rgba(50, 50, 50, 0.85);
	/* slightly lighter than background */
	backdrop-filter: blur(12px);
	border-radius: 16px;
	padding: 25px;
	box-shadow: 0 15px 30px rgba(0, 0, 0, 0.35);
	transition: transform 0.3s ease;
}

.stat-card:hover {
	transform: translateY(-6px);
}

.stat-number {
	font-size: 2rem;
	font-weight: 700;
	color: #ffc107; /* gold accent */
}

.action-card {
	background: rgba(50, 50, 50, 0.85);
	backdrop-filter: blur(12px);
	border-radius: 18px;
	border: 1px solid rgba(255, 184, 0, 0.2);
	transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.action-card:hover {
	transform: translateY(-8px);
	box-shadow: 0 15px 35px rgba(255, 184, 0, 0.25);
}

.action-card h5 {
	font-weight: 600;
	color: #ffd54f;
}

.report-card {
	background: rgba(50, 50, 50, 0.85);
	backdrop-filter: blur(12px);
	border-radius: 18px;
	border: 1px solid rgba(255, 184, 0, 0.2);
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
	<nav class="navbar navbar-dark fixed-top custom-navbar">
		<div class="container">
			<span class="navbar-brand">🏋️ Gym Management</span> <a
				href="${pageContext.request.contextPath}/logout"
				class="btn btn-outline-light btn-sm logout-btn"> Logout </a>
		</div>
	</nav>

	<!-- Dashboard -->
	<div class="container dashboard-container">

		<h2 class="fw-semibold mb-4">Welcome back, Admin 👋</h2>

		<!-- Stats Row -->
		<!-- Stats Row -->
		<div class="row g-4 mb-4">

			<!-- Total Members -->
			<div class="col-md-4">
				<div class="card text-white shadow-lg border-0 rounded-4"
					style="background: linear-gradient(135deg, #FF6B6B, #FFD93D);">
					<div class="card-body d-flex align-items-center">
						<div class="me-3">
							<i class="bi bi-people-fill fs-1"></i>
							<!-- Bootstrap icon -->
						</div>
						<div>
							<h2 class="card-title mb-1">${totalMembers}</h2>
							<p class="card-text small">Total Members</p>
						</div>
					</div>
				</div>
			</div>

			<!-- Active Trainers -->
			<div class="col-md-4">
				<div class="card text-white shadow-lg border-0 rounded-4"
					style="background: linear-gradient(135deg, #4ECDC4, #556270);">
					<div class="card-body d-flex align-items-center">
						<div class="me-3">
							<i class="bi bi-person-badge-fill fs-1"></i>
						</div>
						<div>
							<h2 class="card-title mb-1">${totalTrainers}</h2>
							<p class="card-text small">Active Trainers</p>
						</div>
					</div>
				</div>
			</div>

			<!-- Membership Plans -->
			<div class="col-md-4">
				<div class="card text-white shadow-lg border-0 rounded-4"
					style="background: linear-gradient(135deg, #1A535C, #4ECDC4);">
					<div class="card-body d-flex align-items-center">
						<div class="me-3">
							<i class="bi bi-card-checklist fs-1"></i>
						</div>
						<div>
							<h2 class="card-title mb-1">${totalPlans}</h2>
							<p class="card-text small">Membership Plans</p>
						</div>
					</div>
				</div>
			</div>

		</div>


		<!-- Action Cards -->
		<div class="row g-4">

			<div class="col-md-4">
				<div class="action-card p-4 text-center h-100">
					<h5>Trainers</h5>
					<p class="text-light small">Add, update, and remove trainers</p>
					<a href="${pageContext.request.contextPath}/admin/trainers"
						class="btn btn-outline-warning w-100"> Manage Trainers </a>
				</div>
			</div>

			<div class="col-md-4">
				<div class="action-card p-4 text-center h-100">
					<h5>Members</h5>
					<p class="text-light small">View and manage gym members</p>
					<a href="${pageContext.request.contextPath}/admin/members"
						class="btn btn-outline-success w-100"> Manage Members </a>
				</div>
			</div>

			<div class="col-md-4">
				<div class="action-card p-4 text-center h-100">
					<h5>Plans</h5>
					<p class="text-light small">Create and manage membership plans
					</p>
					<a href="${pageContext.request.contextPath}/admin/plans"
						class="btn btn-outline-primary w-100"> Manage Plans </a>
				</div>
			</div>

			<!-- Export Reports (Collapsible) -->
			<div class="col-12">
				<div class="report-card p-4 mt-3 shadow-sm"
					style="border-radius: 16px; background: rgba(50, 50, 50, 0.9);">
					<h4 class="fw-semibold mb-3" style="cursor: pointer;"
						data-bs-toggle="collapse" data-bs-target="#exportReportsContent"
						aria-expanded="false" aria-controls="exportReportsContent">
						📄 Export Reports <span class="ms-2">▼</span>
					</h4>

					<!-- Collapsible Content -->
					<div class="collapse" id="exportReportsContent">
						<div class="row g-4 text-center mt-3">

							<!-- Members Export -->
							<div
								class="col-md-4 d-flex flex-column align-items-center justify-content-center">
								<h6 class="fw-semibold mb-3">Members</h6>
								<div class="d-flex gap-2">
									<a
										href="${pageContext.request.contextPath}/admin/export/members/pdf"
										class="btn btn-danger btn-sm px-4 shadow-sm"> Export PDF </a>
									<a
										href="${pageContext.request.contextPath}/admin/export/members/excel"
										class="btn btn-primary btn-sm px-4 shadow-sm"> Export
										Excel </a>
								</div>
							</div>

							<!-- Trainers Export -->
							<div
								class="col-md-4 d-flex flex-column align-items-center justify-content-center">
								<h6 class="fw-semibold mb-3">Trainers</h6>
								<div class="d-flex gap-2">
									<a
										href="${pageContext.request.contextPath}/admin/export/trainers/pdf"
										class="btn btn-danger btn-sm px-4 shadow-sm"> Export PDF </a>
									<a
										href="${pageContext.request.contextPath}/admin/export/trainers/excel"
										class="btn btn-primary btn-sm px-4 shadow-sm"> Export
										Excel </a>
								</div>
							</div>

							<!-- Plans Export -->
							<div
								class="col-md-4 d-flex flex-column align-items-center justify-content-center">
								<h6 class="fw-semibold mb-3">Plans</h6>
								<div class="d-flex gap-2">
									<a
										href="${pageContext.request.contextPath}/admin/export/plans/pdf"
										class="btn btn-danger btn-sm px-4 shadow-sm"> Export PDF </a>
									<a
										href="${pageContext.request.contextPath}/admin/export/plans/excel"
										class="btn btn-primary btn-sm px-4 shadow-sm"> Export
										Excel </a>
								</div>
							</div>

						</div>
					</div>
				</div>
			</div>

			<div class="col-md-12">
				<div class="action-card p-4 text-center h-100">
					<h5>Messages</h5>
					<p class="text-light small">Messages from trainers and members
					</p>
					<a href="${pageContext.request.contextPath}/admin/messages"
						class="btn btn-outline-info w-100"> View Messages </a>
				</div>
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


