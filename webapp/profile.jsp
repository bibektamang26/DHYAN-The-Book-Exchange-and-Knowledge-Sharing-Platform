<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%-- FIX 1: Import the required Java Utility List and your local Book Model --%>
<%@ page import="java.util.List"%>
<%@ page import="com.dhyan.model.Book"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Profile</title>
<link class="nav-logo" rel="icon" type="image/png"
	href="assets/icons/logo.png" />
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
				if (session.getAttribute("profileSuccessMessage") != null) {
				%>
				<div style="color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 12px; margin: 20px 0; border-radius: 6px; font-weight: 500; text-align: center; font-family: 'Inter', sans-serif;">
					<i class="fa-solid fa-circle-check" style="margin-right: 6px;"></i> <%= session.getAttribute("profileSuccessMessage") %>
				</div>
				<%
				session.removeAttribute("profileSuccessMessage"); // Clear it so it doesn't show again on refresh
				}
				%>

				<%
				if (session.getAttribute("profileErrorMessage") != null) {
				%>
				<div style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 12px; margin: 20px 0; border-radius: 6px; font-weight: 500; text-align: center; font-family: 'Inter', sans-serif;">
					<i class="fa-solid fa-circle-xmark" style="margin-right: 6px;"></i> <%= session.getAttribute("profileErrorMessage") %>
				</div>
				<%
				session.removeAttribute("profileErrorMessage"); // Clear it so it doesn't show again on refresh
				}
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
							<h1 id="profile-name">
								<span style="color: #244ea2;">${sessionScope.user.fullName}</span>
							</h1>
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
								<div class="ranking-subtitle">Top 5% of Knowledge Sharers</div>
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

					<div class="books-grid" id="my-books-grid">
												<%
							// Unpack request list array passed over by ProfileServlet
							List<Book> myPersonalBooksList = (List<Book>) request.getAttribute("myPersonalBooksList");
							
							if (myPersonalBooksList != null && !myPersonalBooksList.isEmpty()) {
								for (Book myBook : myPersonalBooksList) {
									
									// Determine badge color class based on the database status
									String badgeClass = "badge-available";
									if (myBook.getStatus() != null && "exchanged".equalsIgnoreCase(myBook.getStatus())) {
										badgeClass = "badge-lent"; 
									}
						%>
									<!-- INDIVIDUAL USER BOOK ITEM -->
									<div class="book-item">
										
										<!-- BOOK COVER -->
										<div class="book-cover">
											<img src="<%= request.getContextPath() %>/<%= myBook.getCoverImagePath() %>" 
											     alt="<%= myBook.getTitle() %>" 
											     style="width: 100%; height: 100%; object-fit: cover;" />
										</div>

										<!-- TITLE -->
										<div class="book-title"><%= myBook.getTitle() %></div>

										<!-- AUTHOR -->
										<div class="book-author"><%= myBook.getAuthor() %></div>

										<!-- FLEX ROW: Places the badge and delete button side-by-side -->
										<div style="display: flex; justify-content: space-between; align-items: center; margin-top: auto; width: 100%;">
											
											<!-- BADGE STATUS -->
											<span class="badge <%= badgeClass %>" style="margin: 0;">
												<%= myBook.getStatus().toUpperCase() %>
											</span>
											
											<!-- THE DELETE BUTTON (Positioned right beside the badge) -->
											<a href="DeleteBookServlet?id=<%= myBook.getBookID() %>" 
											   style="color: #ef4444; font-size: 11px; margin-right: 8px;text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 4px;" 
											   onclick="return confirm('Remove this book from your library?');">
												<i class="fa-solid fa-trash-can"></i> 
											</a>
											
										</div>
									</div>
						<%
								}
							} else { 
						%>
							<div class="no-personal-books" style="grid-column: 1/-1; text-align: center; padding: 40px; color: #94a3b8;">
								<i class="fa-solid fa-square-plus" style="font-size: 42px; margin-bottom: 12px; color: #cbd5e1;"></i>
								<h3 style="margin: 0 0 4px 0; color: var(--text-main); font-family: 'Merriweather', serif;">Your Library Is Empty</h3>
								<p style="margin: 0;">Any books you upload via the Dashboard modal popup will show up here for you to manage.</p>
							</div>
						<%
							}
						%>
				</div>

			</div>
		</main>
		<script src="assets/js/main.js"></script>
		<script src="assets/js/ui.js"></script>
		<script src="assets/js/profile.js"></script>
	</div>
</body>
</html>
