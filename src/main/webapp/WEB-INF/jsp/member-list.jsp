<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Members | Gym Management System</title>

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

/* Expired Plan Highlight */
.expired {
	background-color: #f8d7da !important; /* red for expired plans */
}

/* Buttons */
.btn-primary, .btn-warning, .btn-danger, .btn-success {
	border-radius: 30px;
	font-weight: 600;
	padding: 5px 20px;
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

.btn-warning:hover {
	background: #ffb800;
	color: #1a1a1a;
	border-color: #ffb800;
}

.btn-danger:hover {
	background: #ff4c4c;
	color: #fff;
}

.btn-success:hover {
	background: #28a745;
	color: #fff;
}

/* Back link */
.back-link {
	color: #ffb800;
	text-decoration: none;
}

.back-link:hover {
	text-decoration: underline;
}

/* Footer */
footer {
	background: rgba(34, 34, 34, 0.95);
	border-top: 1px solid rgba(255, 184, 0, 0.35);
	color: #f5f5f5;
	font-weight: 600;
}
/* Sort arrow styling */
.sort-arrow {
	display: inline-block;
	font-size: 0.8em;
	margin-left: 5px;
	transition: color 0.3s ease, transform 0.3s ease;
	color: #ffb800; /* gold color */
	cursor: pointer;
}

/* Active arrow highlight */
.sort-arrow.active {
	color: #28a745; /* green for active sort */
	transform: scale(1.3); /* slight enlargement */
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
			<h2 class="fw-bold">Member List</h2>
			<div>
				<a href="/admin/members/add" class="btn btn-primary me-2">+ Add
					Member</a> <a href="/admin/export/members/pdf"
					class="btn btn-danger me-1">Export PDF</a> <a
					href="/admin/export/members/excel" class="btn btn-success">Export
					Excel</a>
			</div>
		</div>

		<div class="glass-card p-3">
			<div class="table-responsive">
				<table id="membersTable"
					class="table table-bordered table-hover align-middle table-custom">
					<thead>
						<tr>
							<th onclick="sortTable(0)">ID <span class="sort-arrow"
								id="arrow-0">▲▼</span></th>
							<th onclick="sortTable(1)">Name <span class="sort-arrow"
								id="arrow-1">▲▼</span></th>
							<th onclick="sortTable(2)">Email <span class="sort-arrow"
								id="arrow-2">▲▼</span></th>
							<th onclick="sortTable(3)">Trainer <span class="sort-arrow"
								id="arrow-3">▲▼</span></th>
							<th onclick="sortTable(4)">Plan <span class="sort-arrow"
								id="arrow-4">▲▼</span></th>
							<th onclick="sortTable(5)">Start Date <span
								class="sort-arrow" id="arrow-5">▲▼</span></th>
							<th onclick="sortTable(6)">Plan Expiry <span
								class="sort-arrow" id="arrow-6">▲▼</span></th>
							<th>Actions</th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="member" items="${members}">
							<tr>
								<td>${member.id}</td>
								<td>${member.name}</td>
								<td>${member.email}</td>
								<td><c:out
										value="${member.trainer != null ? member.trainer.name : ''}" /></td>
								<td><c:out
										value="${member.plan != null ? member.plan.name : ''}" /></td>
								<td>${member.planStartDate}</td>
								<td
									class="${member.planExpiryDate != null && member.planExpiryDate lt today ? 'expired' : ''}">
									<c:choose>
										<c:when test="${member.planExpiryDate != null}">
            ${member.planExpiryDate}
        </c:when>
										<c:otherwise>
            N/A
        </c:otherwise>
									</c:choose>
								</td>

								<td class="text-center"><a
									href="/admin/members/edit/${member.id}"
									class="btn btn-sm btn-warning me-1">Edit</a> <a
									href="${pageContext.request.contextPath}/admin/members/delete/${member.id}"
									class="btn btn-sm btn-danger"
									onclick="return confirm('Are you sure you want to delete this member?');">
										Delete </a> <a
									href="${pageContext.request.contextPath}/admin/members/receipt/${member.id}"
									class="btn btn-sm btn-success">Receipt</a></td>
							</tr>
						</c:forEach>
						<c:if test="${empty members}">
							<tr>
								<td colspan="8" class="text-center text-muted">No members
									found</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
		<!-- Button to show deleted members -->
		<button id="toggleDeletedBtn" class="btn btn-outline-warning ms-2">Show
			Deleted Members</button>

		<!-- Deleted Members Table (hidden by default) -->
		<div id="deletedMembersTable" class="glass-card p-3 mt-4"
			style="display: none;">
			<h4 class="mb-3 text-warning">Deleted Members</h4>
			<div class="table-responsive">
				<table
					class="table table-bordered table-hover align-middle table-custom">
					<thead>
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>

							<th>Trainer</th>
							<th>Plan</th>
							<th>Start Date</th>
							<th>Plan Expiry</th>
							<th>Deleted At</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="deleted" items="${deletedMembers}">
							<tr>
								<td>${deleted.id}</td>
								<td>${deleted.name}</td>
								<td>${deleted.email}</td>

								<td>${deleted.trainerName}</td>
								<td>${deleted.planName}</td>
								<td>${deleted.planStartDate}</td>
								<td>${deleted.planExpiryDate}</td>
								<td>${deleted.deletedAt}</td>
							</tr>
						</c:forEach>
						<c:if test="${empty deletedMembers}">
							<tr>
								<td colspan="9" class="text-center text-muted">No deleted
									members found</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>


		<div class="mt-3">
			<a href="/admin/dashboard" class="back-link">← Back to Dashboard</a>
		</div>

	</div>

	<!-- Footer -->
	<footer class="text-center py-3"> © 2025 Gym Management System
	</footer>
	<script>
window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const showReceipt = urlParams.get('showReceipt');
    const memberId = urlParams.get('memberId');

    if (showReceipt === 'true' && memberId) {
        // Open the PDF in a new tab
        window.open('/admin/members/receipt?id=' + memberId, '_blank');
    }
});
</script>
	<script>
let sortDirection = []; // true = ascending, false = descending

function sortTable(colIndex) {
    const table = document.getElementById("membersTable");
    const tbody = table.tBodies[0];
    const rows = Array.from(tbody.rows);

    if (sortDirection[colIndex] === undefined) sortDirection[colIndex] = true;

    const isDateColumn = colIndex === 5 || colIndex === 6;
    const isNumberColumn = colIndex === 0;

    rows.sort((a, b) => {
        let aText = a.cells[colIndex].innerText.trim();
        let bText = b.cells[colIndex].innerText.trim();

        if (isNumberColumn) {
            return sortDirection[colIndex] ? aText - bText : bText - aText;
        } else if (isDateColumn) {
            let aDate = aText === 'N/A' ? new Date(0) : new Date(aText);
            let bDate = bText === 'N/A' ? new Date(0) : new Date(bText);
            return sortDirection[colIndex] ? aDate - bDate : bDate - aDate;
        } else {
            return sortDirection[colIndex]
                ? aText.localeCompare(bText)
                : bText.localeCompare(aText);
        }
    });

    rows.forEach(row => tbody.appendChild(row));
    sortDirection[colIndex] = !sortDirection[colIndex];

    updateArrows(colIndex, sortDirection[colIndex]);
}

function updateArrows(activeCol, ascending) {
    const arrows = document.querySelectorAll('.sort-arrow');
    arrows.forEach((arrow, index) => {
        arrow.classList.remove('active');
        arrow.innerText = '▲▼';
        if(index === activeCol) {
            arrow.innerText = ascending ? '▲' : '▼';
            arrow.classList.add('active');
        }
    });
}
</script>

	<script>
document.addEventListener('DOMContentLoaded', () => {
    const toggleBtn = document.getElementById('toggleDeletedBtn');
    const deletedTable = document.getElementById('deletedMembersTable');

    if (toggleBtn && deletedTable) {
        toggleBtn.addEventListener('click', () => {
            if (deletedTable.style.display === 'none') {
                deletedTable.style.display = 'block';
                toggleBtn.textContent = 'Hide Deleted Members';
            } else {
                deletedTable.style.display = 'none';
                toggleBtn.textContent = 'Show Deleted Members';
            }
        });
    }
});
</script>




	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
