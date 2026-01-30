<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Update Profile</title>
<!-- Bootstrap CSS for better styling -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body class="bg-light">

	<div class="container my-5">
		<div class="col-md-6 offset-md-3">
			<div class="card shadow-sm">
				<div class="card-body p-4">

					<h2 class="text-center mb-4">Update Profile</h2>

					<form action="/member/update" method="post">
						<input type="hidden" name="id" value="${member.id}" />

						<div class="mb-3">
							<label class="form-label">Name</label> <input type="text"
								name="name" value="${member.name}" class="form-control" required />
						</div>

						<div class="mb-3">
							<label class="form-label">Email</label> <input type="email"
								name="email" value="${member.email}" class="form-control"
								required />
						</div>

						<div class="mb-3">
							<label class="form-label">Password</label> <input type="password"
								name="password" value="${member.password}" class="form-control"
								required />
						</div>

						<!-- Read-only Plan Info -->
						<div class="mb-3">
							<label class="form-label">Plan</label> <input type="text"
								value="${member.plan.name}" class="form-control" readonly />
						</div>

						<div class="mb-3">
							<label class="form-label">Plan Expiry Date</label> <input
								type="text" value="${member.planExpiryDate}"
								class="form-control" readonly />
						</div>

						<div class="text-center">
							<input type="submit" value="Update" class="btn btn-primary" />
						</div>
					</form>

					<div class="text-center mt-3">
						<a href="/member/dashboard" class="btn btn-secondary btn-sm">Back
							to Dashboard</a>
					</div>

				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>





