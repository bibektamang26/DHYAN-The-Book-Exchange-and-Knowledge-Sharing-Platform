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
		
		<%@ page import="com.dhyan.model.User"%>
		<%
		// the user object from session memory
		User loggedInUser = (User) session.getAttribute("user");
		
		//Protect against NullPointerException if session expires or doesn't exist
		if (loggedInUser == null) {
		    response.sendRedirect("login.jsp?error=SessionExpired");
		    return;
		}
		%>
		
		<main>
			<div class="dashboard">
				<!-- Header -->
				<header class="dashboard-header">
					<div class="header-text">
						<h1>
							<!-- 3. Renders the full name safely straight out of your User object -->
							Welcome, <span style="color: #244ea2;">${sessionScope.user.fullName} !</span>
						</h1>
						<p>Here's what's happening in your reading community today.</p>
					</div>
					<button class="btn-add-book">
						<i class="fa-solid fa-plus"></i> Add Book
					</button>
				</header>
				<%
				if (session.getAttribute("dashboardSuccessMessage") != null) {
				%>
				<div style="color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 12px; margin-bottom: 20px; border-radius: 6px; font-weight: 500; font-family: 'Inter', sans-serif;">
					<i class="fa-solid fa-circle-check" style="margin-right: 6px;"></i> <%= session.getAttribute("dashboardSuccessMessage") %>
				</div>
				<%
				session.removeAttribute("dashboardSuccessMessage");
				}
				%>

				<%
				if (session.getAttribute("dashboardErrorMessage") != null) {
				%>
				<div style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 12px; margin-bottom: 20px; border-radius: 6px; font-weight: 500; font-family: 'Inter', sans-serif;">
					<i class="fa-solid fa-triangle-exclamation" style="margin-right: 6px;"></i> <%= session.getAttribute("dashboardErrorMessage") %>
				</div>
				<%
				session.removeAttribute("dashboardErrorMessage"); 
				}
				%>

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
							<a href="books.jsp" class="view-all-link">View all</a>
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
				
				<!-- Hidden Add Book Pop-Up Modal Template -->
				<div id="addBookModal" class="modal-overlay"
					style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0, 0, 0, 0.5); justify-content: center; align-items: center; z-index: 1000;">
					<div class="modal-content"
						style="background: var(--card-bg, #fff); padding: 25px; border-radius: 12px; width: 450px; box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);">

						<div class="modal-header"
							style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
							<h2
								style="margin: 0; font-family: 'Merriweather', serif; color: var(--text-main);">Add
								a Book</h2>
							<span style="cursor: pointer; font-size: 24px; color: #94a3b8;"
								onclick="closeBookModal()">&times;</span>
						</div>

						<!-- Real native HTML Form that sends the cover file cleanly to Java -->
						<form action="AddBookServlet" method="POST"
							enctype="multipart/form-data" id="realBookForm">
							<div style="margin-bottom: 15px;">
								<label
									style="display: block; margin-bottom: 5px; font-weight: 500;">Title</label>
								<input type="text" name="title" placeholder="Book title"
									style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box;"
									required>
							</div>

							<div style="margin-bottom: 15px;">
								<label
									style="display: block; margin-bottom: 5px; font-weight: 500;">Author</label>
								<input type="text" name="author" placeholder="Author name"
									style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box;"
									required>
							</div>

							<div style="margin-bottom: 15px;">
								<label
									style="display: block; margin-bottom: 5px; font-weight: 500;">Category</label>
								<select name="category"
									style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box;">
									<option value="Self-Help">Self-Help</option>
									<option value="Fiction">Fiction</option>
									<option value="Memoir">Memoir</option>
									<option value="Philosophy">Philosophy</option>
									<option value="Social Realism Fiction">Social Realism Fiction</option>
									<option value="Science Fiction">Science Fiction</option>
									<option value="Other">Other</option>
								</select>
							</div>

							<div style="margin-bottom: 15px;">
								<label
									style="display: block; margin-bottom: 5px; font-weight: 500;">Your
									Area</label> <input type="text" name="location" placeholder="e.g. KTM"
									style="width: 100%; padding: 10px; border: 1px solid #cbd5e1; border-radius: 6px; box-sizing: border-box;"
									required>
							</div>

							<div style="margin-bottom: 20px;">
								<label
									style="display: block; margin-bottom: 5px; font-weight: 500;">Book
									Cover</label> <input type="file" name="bookCover" accept="image/*"
									style="width: 100%;" required>
							</div>

							<div style="display: flex; justify-content: flex-end; gap: 10px;">
								<button type="button"
									style="padding: 10px 20px; background: #e2e8f0; border: none; border-radius: 6px; cursor: pointer;"
									onclick="closeBookModal()">Cancel</button>
								<button type="submit"
									style="padding: 10px 20px; background: #244ea2; color: white; border: none; border-radius: 6px; cursor: pointer; font-weight: 500;">Add
									Book</button>
							</div>
						</form>
					</div>
				</div>

			</div>
		</main>
	</div>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/dashboard.js"></script>
</body>
</html>
