<%@page import="com.dhyan.model.User"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<%-- FIX 1: Import the required Java Utility List and your local Book Model --%>
<%@ page import="java.util.List"%>
<%@ page import="com.dhyan.model.Book"%>
<%@ page import="com.dhyan.model.User"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=de	vice-width, initial-scale=1.0" />
<title>DHYAN | Browse Books</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>
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

<!-- Page CSS -->
<link rel="stylesheet" href="assets/css/books.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>
<body>

	<div class="bookspage-layout">
		<div id="sidebar">
			<jsp:include page="/components/sidebar.jsp" />
		</div>
		<main>
			<header class="topbar">
				<div class="search-wrapper">
					<div class="search">
						<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
							id="book-search"
							placeholder="Search for books, authors, or ISBN..." />
					</div>
				</div>
				<div class="topbar-actions">
					<button class="icon-btn" id="notification">
						<span class="notification-number">1</span> <i
							class="fa-regular fa-bell"></i>
					</button>
					<button class="icon-btn">
						<i class="fa-regular fa-circle-user"></i>
					</button>
				</div>
			</header>

			<div class="page">
				<div class="page-header">
					<div class="header-info">
						<h2 class="page-title">Explore Library</h2>
						<p class="page-subtitle">Discover books shared by your local
							community.</p>
					</div>
				</div>

				<div class="filter-bar">
					<div class="filter-group">
						<select class="filter-dropdown" id="filter-category">
							<option value="all">All Categories</option>
							<option value="self-help">Self-Help</option>
							<option value="fiction">Fiction</option>
							<option value="memoir">Memoir</option>
							<option value="sci-fi">Science Fiction</option>
						</select> <select class="filter-dropdown" id="filter-availability">
							<option value="all">Availability</option>
							<option value="available">Available</option>
							<option value="exchanged">Exchanged</option>
						</select> <select class="filter-dropdown" id="filter-distance">
							<option value="any">Distance</option>
							<option value="1">Under 1 mi</option>
							<option value="5">Under 5 mi</option>
							<option value="10">Under 10 mi</option>
						</select>
					</div>
					<button class="more-filters" id="clear-filters-btn">
						<i class="fa-solid fa-sliders"></i> Clear Filters
					</button>
				</div>
					
					
				<!-- DYNAMIC BOOK GRID -->
				<div class="book-grid" id="book-grid">
					<%
					List<Book> sqlBooksList = (List<Book>) request.getAttribute("sqlBooksList");

					User currentUser = (User) session.getAttribute("user");
					int currentUserId = (currentUser != null) ? currentUser.getUserID() : -1;

					boolean hasVisibleBooks = false;

					if (sqlBooksList != null && !sqlBooksList.isEmpty()) {
						for (Book book : sqlBooksList) {

							if (book.getUserID() == currentUserId) {
						continue;
							}

							// Mark that we found a valid book belonging to someone else
							hasVisibleBooks = true;
					%>
					<!-- BOOK CARD -->
					<div class="book-card">
						<!-- BOOK COVER -->
						<div class="book-cover">
							<div class="image-wrapper">
								<img
									src="<%=request.getContextPath()%>/<%=book.getCoverImagePath()%>"
									alt="<%=book.getTitle()%>" />
							</div>

							<!-- BOOKMARK -->
							<button class="bookmark-btn">
								<i class="fa-regular fa-bookmark"></i>
							</button>

							<!-- STATUS -->
							<span
								class="status-badge <%=book.getStatus() != null ? book.getStatus().toLowerCase() : "available"%>">
								<%=book.getStatus()%>
							</span>
						</div>

						<!-- BOOK INFORMATION -->
						<div class="book-info">
							<span class="book-category"><%=book.getCategory()%></span>
							<h3 class="book-title"><%=book.getTitle()%></h3>
							<p class="book-author"><%=book.getAuthor()%></p>

							<!-- BOTTOM INFORMATION -->
							<div class="book-meta">
								<span class="book-distance"> <i
									class="fa-solid fa-location-dot"></i> <%=book.getArea()%>
								</span>
								<form action="RequestServlet" method="post"
									style="display: inline;">
									<input type="hidden" name="action" value="submitNewRequest" />
									<input type="hidden" name="bookID"
										value="<%=book.getBookID()%>" /> <input type="hidden"
										name="receiverID" value="<%=book.getUserID()%>" />
									<button onclick="return confirm('do you want to request?')"
										type="submit" class="action request" style="cursor: pointer;">Request</button>

								</form>
							</div>
						</div>
					</div>
					<%
					}
					}

					if (!hasVisibleBooks) {
					%>
					<!-- FALLBACK CASE IF DATABASE GRID IS EMPTY -->
					<div class="no-books-message"
						style="grid-column: 1/-1; text-align: center; padding: 60px 20px; color: #94a3b8;">
						<i class="fa-solid fa-book-open"
							style="font-size: 54px; margin-bottom: 20px; color: #cbd5e1;"></i>
						<h3
							style="font-family: 'Merriweather', serif; color: var(--text-main); margin-bottom: 8px;">No
							books available</h3>
						<p>There are no books shared by other members of the community
							right now.</p>
					</div>
					<%
					}
					%>
				</div>

			</div>
		</main>
	</div>

	<!-- JavaScript -->
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/books.js"></script>
</body>
</html>
