<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<script src="assets/js/theme.js"></script>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Community</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- page css -->
<link rel="stylesheet" href="assets/css/community.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<div class="layout">
		<div id="sidebar">
			<jsp:include page="/components/sidebar.jsp" />
		</div>

		<main>
			<div class="community-feed">
				<div class="feed-main">
					<header class="feed-header">
						<div class="feed-header-text">
							<h1>Community Feed</h1>
							<p>Discuss books, share insights, and connect with fellow
								readers.</p>
						</div>
						<button class="btn-new-post">
							<i class="fa-solid fa-pen"></i> New Post
						</button>
					</header>

					<div class="new-post-box">
						<a href="profile.jsp"><img
							src="assets/images/profile5.png" alt="Your avatar" class="avatar"
							data-user-avatar /></a>
						<div class="new-post-input">
							<textarea type="text" id="new-post-text"
								placeholder="What are you reading right now? Share your thoughts..."></textarea>
							<div class="new-post-actions">
								<div class="new-post-icons">
									<button class="icon-btn">
										<i class="fa-regular fa-image"></i>
									</button>
									<button class="icon-btn">
										<i class="fa-solid fa-book-open"></i>
									</button>
								</div>
								<button class="btn-post" id="new-post-submit">Post</button>
							</div>
						</div>
					</div>

					<div id="post-feed"></div>

					<button class="btn-load-more" id="load-more-btn">Load More
						Discussions</button>
				</div>
				<aside class="feed-sidebar">
					<div class="sidebar-card">
						<h3>
							<i class="fa-solid fa-arrow-trend-up"></i> Trending Topics
						</h3>
						<ul class="trending-list">
							<li>
								<p class="trend-name">#StudyTips</p>
								<p class="trend-count">1.2k posts this week</p>
							</li>
							<li>
								<p class="trend-name">#Fiction</p>
								<p class="trend-count">850 posts this week</p>
							</li>
							<li>
								<p class="trend-name">#HistoricalNonFiction</p>
								<p class="trend-count">420 posts this week</p>
							</li>
							<li>
								<p class="trend-name">#PoetryMonth</p>
								<p class="trend-count">315 posts this week</p>
							</li>
						</ul>
					</div>

					<div class="sidebar-card">
						<h3>
							<i class="fa-solid fa-award"></i> Top Contributors
						</h3>
						<ul class="contributors-list">
							<li><img src="assets/images/profile2.jpeg" alt="Rekha Thapa"
								class="avatar avatar-sm" />
								<div class="contributor-info">
									<p class="contributor-name">Rekha Thapa</p>
									<p class="contributor-stat">42 Books Shared</p>
								</div>
								<button class="icon-btn follow-btn">
									<i class="fa-solid fa-user-plus"></i>
								</button></li>
							<li><img src="assets/images/profile3.jpeg"
								alt="Rajesh Hamal" class="avatar avatar-sm" />
								<div class="contributor-info">
									<p class="contributor-name">Saugat Malla</p>
									<p class="contributor-stat">38 Books Shared</p>
								</div>
								<button class="icon-btn follow-btn">
									<i class="fa-solid fa-user-plus"></i>
								</button></li>
							<li><img src="assets/images/profile4.jpeg"
								alt="Suvashan Baniya" class="avatar avatar-sm" />
								<div class="contributor-info">
									<p class="contributor-name">Suvashan Baniya</p>
									<p class="contributor-stat">29 Books Shared</p>
								</div>
								<button class="icon-btn follow-btn">
									<i class="fa-solid fa-user-plus"></i>
								</button></li>
						</ul>
					</div>
				</aside>
			</div>
		</main>
	</div>
	
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/community.js"></script>
</body>
</html>
