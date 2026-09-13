<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>DHYAN | Login</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>

<!-- Font-awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" />
<link
	href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
	rel="stylesheet" />

<!-- Global CSS -->
<link rel="stylesheet" href="assets/css/variables.css" />
<link rel="stylesheet" href="assets/css/components.css" />

<!-- Page CSS -->
<link rel="stylesheet" href="assets/css/login.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<main class="login">
		<%
		if (session.getAttribute("successMessage") != null) {
		%>
		<div
			style="color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 12px; margin-bottom: 20px; border-radius: 4px; font-weight: bold; text-align:center;">
			<%=session.getAttribute("successMessage")%>
		</div>
		<%
		session.removeAttribute("successMessage");
		%>
		<%
		}
		%>
		<%
		if (session.getAttribute("errorMessage") != null) {
		%>
		<div
			style="color: #721c24; text-align:center; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 12px; margin-bottom: 20px; border-radius: 4px; font-weight: bold;">
			<%=session.getAttribute("errorMessage")%>
		</div>
		<%
		session.removeAttribute("errorMessage");
		%>
		<%
		}
		%>

		<div class="login-card">
			<div class="logo-section">
				<img src="assets/icons/logo.png" alt="Dhyan Logo" />
				<h1>Welcome Back</h1>
				<p>Enter your credentials to access your library.</p>
			</div>

			<form class="login-form" action="login" method="post">
				<div class="input-group">
					<label for="email">Email Address</label>
					<div class="input-wrapper">
						<input type="email" id="email" placeholder="name@example.com"
							name="email" required /> <span class="icon"><i
							class="fa-solid fa-envelope"></i></span>
					</div>
				</div>

				<div class="input-group">
					<div class="label-row">
						<label for="password">Password</label> <a href="#"
							class="forgot-link">Forgot Password?</a>
					</div>
					<div class="input-wrapper">
						<input type="password" id="password"
							placeholder="Enter your password" name="password" required />
						<span class="icon"><i class="fa-solid fa-lock"></i></span> <span
							class="toggle-password"><i
							class="fa-solid fa-eye"></i></span>
					</div>
				</div>

				<div class="checkbox-group">
					<input type="checkbox" id="remember" /> <label for="remember">Remember
						this device</label>
				</div>

				<button type="submit" class="btn-action btn-primary">
					Sign In <i class="fa-solid fa-arrow-right-to-bracket"></i>
				</button>
			</form>

			<div class="divider">
				<span>OR</span>
			</div>

			<!-- GOOGLE IDENTITY RUNTIME CONFIGURATION -->
			<div id="g_id_onload"
				 data-client_id="469510402526-q0cn4tt98sjui7f3uq9c4imr4e22ldp3.apps.googleusercontent.com"
				 data-context="signin"
				 data-ux_mode="redirect"
				 data-login_uri="http://localhost:8080/Project/google-register"
				 data-auto_prompt="false">
			</div>

			<!-- CUSTOM STYLED GOOGLE BUTTON LAYOUT -->
			<div style="width: 100%; display: flex; justify-content: center; margin-bottom: 20px;padding:4px;">
				<div class="g_id_signin" id = "googleBtnContainer"
					 data-type="standard"
					 data-shape="rectangular"
					 data-text="signin_with" 
					 data-size="large"
					 data-logo_alignment="center"
					 data-locale="en"
					 data-width="350">         
				</div>
			</div>


			<div class="divider">
				<span>NEW TO DHYAN?</span>
			</div>

			<a href="register.jsp" class="btn-action btn-secondary">Create an account</a>
		</div>
	</main>
	<footer class="login-footer">
		<p>&copy; 2026 DHYAN, Shared Knowledge, Growing Together.</p>
		<div class="footer-links">
			<a href="#">Privacy Policy</a> <a href="#">Support</a>
		</div>
	</footer>
	<script src="https://accounts.google.com/gsi/client" async defer></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/login.js"></script>
</body>
</html>

