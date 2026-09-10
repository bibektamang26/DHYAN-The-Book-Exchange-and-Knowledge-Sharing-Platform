<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Dashboard</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>
<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
	rel="stylesheet" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- Font-awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<link rel="stylesheet" href="assets/css/dashboard.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>
<body>
	<div class="layout">
		<div id="sidebar">
			<jsp:include page="/components/sidebar.jsp" />
		</div>
		<main>
			<div class="dashboard">
				<!-- Header -->
				<header class="dashboard-header">
					<div class="header-text">
						<h1>Good morning, Bibek.</h1>
						<p>Here's what's happening in your reading community today.</p>
					</div>
					<button class="btn-add-book">
						<i class="fa-solid fa-plus"></i> Add Book
					</button>
				</header>

				<!-- Stats Cards -->
				<section class="stats-cards">
					<div class="stat-card">
						<div class="stat-icon-row">
							<span class="icon icon-requests"><i
								class="fa-solid fa-arrow-right-arrow-left"></i></span> <span
								class="badge badge-active">Active</span>
						</div>
						<div class="stat-value">12</div>
						<div class="stat-label">Active Requests</div>
					</div>

					<div class="stat-card">
						<div class="stat-icon-row">
							<span class="icon icon-books"><i
								class="fa-solid fa-book-open"></i></span>
						</div>
						<div class="stat-value">47</div>
						<div class="stat-label">Books Shared</div>
					</div>

					<div class="stat-card">
						<div class="stat-icon-row">
							<span class="icon icon-points"><i
								class="fa-regular fa-star"></i></span> <span class="badge badge-growth">+150
								this week</span>
						</div>
						<div class="stat-value">2,450</div>
						<div class="stat-label">Community Points</div>
					</div>
				</section>

				<section class="main-content">
					<div class="recommended-section">
						<div class="section-header">
							<h2>Recommended for You</h2>
							<a href="#" class="view-all-link">View all</a>
						</div>

						<div class="book-cards">
							<div class="book-card">
								<div class="book-cover">
									<span class="tag tag-available">Available</span> <img
										src="assets/images/p5.png" alt="The Daily Stoic cover" />
								</div>
								<h3 class="book-title">The Daily Stoic</h3>
								<p class="book-author">Ryan Holiday</p>
								<span class="tag tag-genre">Philosophy</span>
							</div>

							<div class="book-card">
								<div class="book-cover">
									<span class="tag tag-exchange">Exchange</span> <img
										src="assets/images/book1.png" alt="Atomic Habits cover" />
								</div>
								<h3 class="book-title">Atomic Habits</h3>
								<p class="book-author">James Clear</p>
								<span class="tag tag-genre">Self Help</span>
							</div>

							<div class="book-card">
								<div class="book-cover">
									<img src="assets/images/p3.png" alt="Meditations cover" />
								</div>
								<h3 class="book-title">Meditations</h3>
								<p class="book-author">Marcus Aurelius</p>
								<span class="tag tag-genre">Classics</span>
							</div>
						</div>
					</div>

					<!-- Recent Activity -->
					<div class="recent-activity">
						<h2>Recent Activity</h2>

						<ul class="activity-list">
							<li class="activity-item"><span
								class="activity-icon icon-request"><i
									class="fa-solid fa-arrow-right-arrow-left"></i></span>
								<div class="activity-content">
									<p>
										<strong>Susmita</strong> requested '<em>पल्पसा क्याफे</em>'
									</p>
									<span class="activity-time">2 hours ago</span>
									<div class="activity-actions">
										<button class="btn-accept">Accept</button>
										<button class="btn-decline">Decline</button>
									</div>
								</div></li>

							<li class="activity-item"><span
								class="activity-icon icon-comment"><i
									class="fa-regular fa-message"></i></span>
								<div class="activity-content">
									<p>New comment on your post about Stoicism</p>
									<span class="activity-time">5 hours ago</span>
								</div></li>

							<li class="activity-item"><span
								class="activity-icon icon-complete"><i
									class="fa-regular fa-circle-check"></i></span>
								<div class="activity-content">
									<p>Exchange completed with Mohit</p>
									<span class="activity-time">Yesterday</span>
								</div></li>
						</ul>

						<button class="btn-start-discussion">
							<i class="fa-solid fa-message"></i> Start a Discussion
						</button>
					</div>
				</section>
			</div>
		</main>
	</div>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/dashboard.js"></script>
</body>
</html>
