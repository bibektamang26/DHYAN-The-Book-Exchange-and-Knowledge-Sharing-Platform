<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="com.dhyan.model.User" %>
<%
	// 1. Extract the user object from session memory
	User loggedInUser = (User) session.getAttribute("user");
	
	// 2. Protect against NullPointerException if session expires or doesn't exist
	if (loggedInUser == null) {
	    response.sendRedirect("login.jsp?error=SessionExpired");
	    return; // Stops executing the rest of the page
	}

	// 3. Extract the first name from the User object
	String fullName = loggedInUser.getFullName();
	String firstName = "User"; // Default fallback if name is completely empty
	
	if (fullName != null && !fullName.trim().isEmpty()) {
		firstName = fullName.trim().split("\\s+")[0];
	}
%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Logout</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>

<!-- Google Fonts -->
<link rel="preconnect" href="https://googleapis.com" />
<link rel="preconnect" href="https://gstatic.com" crossorigin />
<link href="https://googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap" rel="stylesheet" />
<link rel="stylesheet" href="https://cloudflare.com" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- page css -->
<link rel="stylesheet" href="assets/css/logout.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<div class="layout">
		<main>
			<div class="auth-card">
				<img src="assets/icons/logo.png" alt="DHYAN logo" class="auth-logo" />

				<h1 class="auth-title">Log back In</h1>

				<div class="auth-avatar">
					<!-- Dynamically matches the user's name in the image alt attribute -->
					<img src="assets/images/profileM.jpeg" alt="<%= firstName %>" />
				</div>

				<button class="btn-continue" onclick="window.location.href='dashboard.jsp'">
					Continue with <%= firstName %>
				</button>

				<div class="auth-links">
					<a href="logout">Switch Account</a> 
					<a href="register.jsp">Create new account</a>
				</div>

				<footer class="auth-footer">
					<p>Need help accessing your books? Contact our support team for
						assistance with academic exchange requests.</p>
				</footer>
			</div>
		</main>
	</div>
	<div id="footer"></div>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/logout.js"></script>
</body>
</html>
