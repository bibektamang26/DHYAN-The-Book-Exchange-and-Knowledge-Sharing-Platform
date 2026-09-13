<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Profile</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- page css -->
<link rel="stylesheet" href="assets/css/profile.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<div class="layout">
		<div id="sidebar">
			<jsp:include page="/components/sidebar.jsp" />
		</div>
		<main>
			<% 
				String fullName = (String)session.getAttribute("fullName");
			%>
			<!-- Profile info -->
			<div class="profile-page">
				<div class="profile-heading">
					<div class="profile-image">
						<div class="image-wrapper">
							<img id="profile-avatar-img" src="assets/images/profile.jpeg"
								alt="" data-user-avatar /> <label for="profile-avatar-input"
								class="avatar-edit-btn" title="Change profile picture">
								<i class="fa-solid fa-camera"></i>
							</label> <input type="file" id="profile-avatar-input" accept="image/*"
								hidden />
						</div>
						<div class="info">
							<h1 id="profile-name"><span style = "color: #244ea2;">${sessionScope.fullName}</span></h1>
							<p id="profile-bio">Avid reader and philosophy enthusiast</p>
						</div>
					</div>
					<button class="edit-profile" id="edit-profile-toggle">
						<i class="fa-solid fa-pencil"></i> Edit Profile
					</button>
				</div>

				<!-- Achievements -->
				<div class="middle-section">
					<div class="left-stats">
						<div class="stat-row">
							<div class="card stat-card">
								<span class="stat-number number-blue" id="stat-books-shared">24</span>
								<span class="stat-label">Books Shared</span>
							</div>
							<div class="card stat-card">
								<span class="stat-number number-green" id="stat-exchanges">18</span>
								<span class="stat-label">Exchanges Completed</span>
							</div>
						</div>
						<div class="card ranking-card">
							<div>
								<div class="ranking-title">Community Ranking</div>
								<div class="ranking-subtitle">Top 5% of Knowledge Sharers
								</div>
							</div>
							<div class="ranking-icon">
								<i class="fa-solid fa-medal"></i>
							</div>
						</div>
					</div>

					<div class="card interests-card">
						<div class="interests-title">Interests</div>
						<div class="tags-container" id="interests-container"></div>
					</div>
				</div>

				<div class="books-section">
					<div class="books-header">
						<h2>My Books</h2>
						<button class="filter-btn" id="my-books-filter">
							<span class="filter-icon"><i class="fa-solid fa-bars"
								style="color: #244ea2;"></i></span> Filter: All
						</button>
					</div>

					<div class="books-grid" id="my-books-grid"></div>
				</div>
			</div>
		</main>
		<script src="assets/js/main.js"></script>
		<script src="assets/js/ui.js"></script>
		<script src="assets/js/profile.js"></script>
	</div>
</body>
</html>
