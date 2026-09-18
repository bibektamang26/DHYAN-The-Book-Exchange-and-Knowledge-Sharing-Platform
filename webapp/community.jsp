<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%@ page import="com.dhyan.model.User"%>
<%@ page import="com.dhyan.model.Post"%>
<%@ page import="java.util.List"%>
<%@ page import="java.sql.Timestamp"%>

<%!// Turns a created_at Timestamp into a short relative label like
	// "2 hours ago" / "Just now" for the post meta line.
	private String timeAgo(Timestamp createdAt) {
		if (createdAt == null) {
			return "";
		}
		long diffMs = System.currentTimeMillis() - createdAt.getTime();
		long minutes = diffMs / (60 * 1000);
		long hours = minutes / 60;
		long days = hours / 24;

		if (minutes < 1) {
			return "Just now";
		} else if (minutes < 60) {
			return minutes + (minutes == 1 ? " minute ago" : " minutes ago");
		} else if (hours < 24) {
			return hours + (hours == 1 ? " hour ago" : " hours ago");
		} else {
			return days + (days == 1 ? " day ago" : " days ago");
		}
	}%>

<!doctype html>
<html lang="en">
<head>
<script src="assets/js/theme.js"></script>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Community</title>

<link rel="icon" type="image/png" href="assets/icons/logo.png" />

<!-- Google Fonts -->
<link rel="preconnect" href="https://googleapis.com" />
<link rel="preconnect" href="https://gstatic.com" />
<link
	href="https://googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
	rel="stylesheet" />
<link rel="stylesheet" href="https://cloudflare.com" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- Page CSS -->
<link rel="stylesheet" href="assets/css/community.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>
<body>

	<div class="layout">
		<%
		User loggedInUser = (User) session.getAttribute("user");

		if (loggedInUser == null) {
			response.sendRedirect("login.jsp?error=SessionExpired");
			return;
		}
		%>

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
					</header>

					<!-- NEW POST -->
					<div class="new-post-box">
						<a href="profile"> <img src="assets/images/default-avatar.png"
							alt="Your avatar" class="avatar" data-user-avatar />
						</a>
						<div class="new-post-input">
							<textarea id="new-post-text"
								placeholder="What are you reading right now? Share your thoughts..."></textarea>

							<div class="new-post-actions">
								<div class="new-post-icons">
									<button type="button" class="icon-btn">
										<i class="fa-regular fa-image"></i>
									</button>
								</div>
								<button type="button" class="btn-post" id="new-post-submit">Post</button>
							</div>
						</div>
					</div>

					<!-- POST FEED -->
					<div id="post-feed">
						<%
						List<Post> posts = (List<Post>) request.getAttribute("posts");

						if (posts != null && !posts.isEmpty()) {
							for (Post post : posts) {
						%>
						<!-- POST CARD -->
						<article class="post-card" data-post-id="<%=post.getPostID()%>"
							data-user-id="<%=post.getUserID()%>">
							<div class="post-header" style="position: relative;">
								<!-- Added relative positioning for context menu -->
								<img src="assets/images/default-avatar.png" alt="User avatar"
									class="avatar" />
								<div class="post-author-info">
									<h4><%=post.getAuthorName()%></h4>
									<p><%=timeAgo(post.getCreated_at())%></p>
								</div>

								<!-- Action Menu Button Container -->
								<div class="post-menu-container">
									<button type="button" class="icon-btn post-menu-btn"
										data-action="post-menu">
										<i class="fa-solid fa-ellipsis"></i>
									</button>

									<%-- ONLY render the context dropdown menu structure if this post belongs to the logged-in user --%>
									<%
									if (loggedInUser != null && loggedInUser.getUserID() == post.getUserID()) {
									%>
									<div class="post-context-menu"
										style="display: none; position: absolute; right: 0; top: 100%; background: var(--bg-surface, #fff); border: 1px solid #e2e8f0; border-radius: 6px; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); z-index: 10; min-width: 120px;">
										<button type="button" class="delete-post-btn"
											style="width: 100%; text-align: left; padding: 10px 16px; background: none; border: none; color: #ef4444; font-size: 14px; cursor: pointer; display: flex; align-items: center; gap: 8px;">
											<i class="fa-regular fa-trash-can"></i> Delete
										</button>
									</div>
									<%
									}
									%>
								</div>
							</div>
							<p class="post-text"><%=post.getContent()%></p>
							<div class="post-footer">
								<div class="post-stats">
									<span><i class="fa-regular fa-heart"></i> <%=post.getLikeCount()%></span>
									<span><i class="fa-regular fa-message"></i> <%=post.getCommentCount()%>
										Comments</span>
								</div>
								<button type="button" class="icon-btn" data-action="share">
									<i class="fa-solid fa-share-nodes"></i>
								</button>
							</div>
						</article>

						<%
						}
						} else {
						%>
						<!-- NO POSTS MESSAGE -->
						<div class="no-posts-message"
							style="text-align: center; padding: 60px 20px; color: #94a3b8;">
							<i class="fa-regular fa-comments"
								style="font-size: 54px; margin-bottom: 20px; color: #cbd5e1;"></i>
							<h3
								style="font-family: 'Merriweather', serif; color: var(--text-main); margin-bottom: 8px;">No
								posts yet</h3>
							<p>Be the first to share what you're reading with the
								community.</p>
						</div>
						<%
						}
						%>
					</div>

					<button type="button" class="btn-load-more" id="load-more-btn">Load
						More Discussions</button>
				</div>

				<!-- RIGHT SIDEBAR -->
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
								</div></li>
							<li><img src="assets/images/profile3.jpeg"
								alt="Saugat Malla" class="avatar avatar-sm" />
								<div class="contributor-info">
									<p class="contributor-name">Saugat Malla</p>
									<p class="contributor-stat">38 Books Shared</p>
								</div></li>
							<li><img src="assets/images/profile4.jpeg"
								alt="Suvashan Baniya" class="avatar avatar-sm" />
								<div class="contributor-info">
									<p class="contributor-name">Suvashan Baniya</p>
									<p class="contributor-stat">29 Books Shared</p>
								</div></li>
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
