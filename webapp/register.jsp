<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>DHYAN | Create Account</title>

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
<link rel="stylesheet" href="assets/css/app.css" />

<!-- Page CSS -->
<style>
body {
	margin: 0;
	font-family: "Inter", sans-serif;
	background-color: #f8fafc;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	background-color: #fbfbfe;
}

.register {
	min-height: 100vh;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	padding: 24px;
	box-sizing: border-box;
	gap: 24px;
	background-color: #fbfbfe;
}

.register-card {
	background-color: #ffffff;
	padding: 36px;
	border-radius: 8px;
	width: 450px;
	max-width: 100%;
	box-shadow: 0 4px 12px rgba(17, 28, 45, 0.05);
	box-sizing: border-box;
}

.logo-section {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	margin-bottom: 24px;
}

.logo-section img {
	height: 72px;
	width: auto;
	object-fit: contain;
	margin-bottom: 12px;
}

.logo-section h1 {
	font-family: "Merriweather", serif;
	font-weight: 700;
	font-size: 24px;
	color: #111c2d;
	margin: 0 0 8px 0;
}

.logo-section p {
	font-size: 14px;
	color: #64748b;
	margin: 0;
}

.register-form {
	display: flex;
	flex-direction: column;
	gap: 16px;
}

.input-group {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.input-row {
	display: flex;
	flex-direction: column;
	gap: 16px;
}

.input-group label {
	font-size: 13px;
	font-weight: 500;
	color: #434652;
}

.label-row {
	display: flex;
	justify-content: space-between;
	align-items: center;
}

.label-row a {
	color: #244ea2;
	font-weight: 500;
	font-size: 12px;
	text-decoration: none;
}

.label-row a:hover {
	text-decoration: underline;
}

.input-wrapper {
	position: relative;
	display: flex;
	align-items: center;
}

.input-wrapper input {
	width: 100%;
	padding: 12px 40px;
	border: 1px solid #e2e8f0;
	border-radius: 6px;
	background-color: #f8fafc;
	font-size: 14px;
	color: #111c2d;
	outline: none;
	transition: border-color 0.2s ease, box-shadow 0.2s ease,
		background-color 0.2s ease;
	box-sizing: border-box;
}

.input-wrapper input:focus {
	border-color: #1d4ed8;
	background-color: #ffffff;
	box-shadow: 0 0 0 3px rgba(29, 78, 216, 0.12);
}

.input-wrapper .icon {
	position: absolute;
	left: 14px;
	color: #94a3b8;
	pointer-events: none;
	transition: color 0.2s ease;
}

.input-wrapper:focus-within .icon {
	color: #1d4ed8;
}

.input-wrapper .toggle-password {
	position: absolute;
	right: 14px;
	cursor: pointer;
	color: #94a3b8;
	padding: 4px;
}

.input-wrapper .toggle-password:hover {
	color: #64748b;
}

.password-hint {
	font-size: 11px;
	color: #94a3b8;
	margin: 2px 0 0 0;
}

.checkbox-group {
	display: flex;
	align-items: flex-start;
	gap: 8px;
	margin: 4px 0;
}

.checkbox-group input[type="checkbox"] {
	cursor: pointer;
	width: 16px;
	height: 16px;
	margin-top: 2px;
	flex-shrink: 0;
}

.checkbox-group label {
	font-size: 13px;
	color: #4a4a4a;
	cursor: pointer;
	user-select: none;
	line-height: 1.5;
}

.checkbox-group label a {
	color: #244ea2;
	font-weight: 500;
	text-decoration: none;
}

.checkbox-group label a:hover {
	text-decoration: underline;
}

.btn-action {
	width: 100%;
	padding: 12px;
	border-radius: 6px;
	font-size: 14px;
	font-weight: 500;
	cursor: pointer;
	display: flex;
	justify-content: center;
	align-items: center;
	gap: 8px;
	box-sizing: border-box;
	text-decoration: none;
	transition: all 0.2s ease;
}

.btn-primary {
	background-color: #1d4ed8;
	color: #ffffff;
	border: none;
}

.btn-primary:hover {
	background-color: #1e40af;
	transform: translateY(-1px);
	box-shadow: 0 6px 14px rgba(29, 78, 216, 0.25);
}

.btn-primary:disabled {
	background-color: #93b0e8;
	cursor: not-allowed;
}

.btn-google {
	background-color: #ffffff;
	border: 1px solid #e2e8f0;
	color: #111c2d;
	margin-bottom: 16px;
}

.btn-google:hover {
	background-color: #eff6ff;
	transform: translateY(-1px);
}

.btn-google img {
	width: 18px;
	height: 18px;
}

.divider {
	text-align: center;
	position: relative;
	margin: 24px 0;
}

.divider::before {
	content: "";
	position: absolute;
	top: 50%;
	left: 0;
	right: 0;
	height: 1px;
	background: #e2e8f0;
	z-index: 1;
}

.divider span {
	background: #ffffff;
	padding: 0 12px;
	font-size: 11px;
	font-weight: 600;
	color: #94a3b8;
	position: relative;
	z-index: 2;
	letter-spacing: 0.5px;
}

.signin-prompt {
	text-align: center;
	font-size: 13px;
	color: #64748b;
	margin: 0;
}

.signin-prompt a {
	color: #1d4ed8;
	font-weight: 600;
	text-decoration: none;
}

.signin-prompt a:hover {
	text-decoration: underline;
}

.login-footer {
	text-align: center;
	width: 100%;
	max-width: 520px;
	font-family: "Inter", sans-serif;
}

.login-footer p {
	font-size: 11px;
	color: #94a3b8;
	margin: 0 0 12px 0;
	letter-spacing: 0.2px;
}

.footer-links {
	display: flex;
	justify-content: center;
	gap: 16px;
}

.footer-links a {
	font-size: 12px;
	font-weight: 500;
	color: #4b5563;
	text-decoration: none;
	transition: color 0.2s ease;
}

.footer-links a:hover {
	color: #1d4ed8;
	text-decoration: underline;
}

/* Responsive Design */
@media ( max-width : 480px) {
	.login {
		padding: 12px;
	}
	.login-card {
		padding: 32px 20px;
		border-radius: 12px;
		box-shadow: none;
	}
	.logo-section h1 {
		font-size: 22px;
	}
	.logo-section img {
		height: 64px;
	}
}
</style>
</head>

<body>
	<main class="register">
		<%
		if (request.getAttribute("errorMessage") != null) {
		%>
		<div
			style="color: #721c24; background-color: #f8d7da; border: 1px solid #f5c6cb; padding: 12px; margin-bottom: 20px; border-radius: 4px; font-weight: bold; font-family: Arial, sans-serif;">
			<%=request.getAttribute("errorMessage")%>
		</div>
		<%
		}
		%>
		<div class="register-card">
			<div class="logo-section">
				<img src="assets/icons/logo.png" alt="Dhyan Logo" />
				<h1>Create Your Account</h1>
				<p>Join our community of knowledge seekers and book lovers.</p>
			</div>

			<form class="register-form" action="register" method="post">

				<div class="input-group">
					<label for="fullname">Full Name</label>
					<div class="input-wrapper">
						<span class="icon"><i class="fa-solid fa-user"></i></span> <input
							type="text" id="fullname" placeholder="Enter your full name"
							name="fullname" required />
					</div>
				</div>

				<div class="input-group">
					<label for="email">Email Address</label>
					<div class="input-wrapper">
						<span class="icon"><i class="fa-solid fa-envelope"></i></span> <input
							type="email" id="email" placeholder="name@example.com"
							name="email" required />
					</div>
				</div>

				<div class="input-row">
					<div class="input-group">
						<label for="password">Password</label>
						<div class="input-wrapper">
							<span class="icon"><i class="fa-solid fa-lock"></i></span> <input
								type="password" id="password" placeholder="Create Password"
								name="password" required /> <span class="toggle-password"><i
								class="fa-solid fa-eye"></i></span>
						</div>
					</div>

					<div class="input-group">
						<label for="confirm-password">Confirm</label>
						<div class="input-wrapper">
							<span class="icon"><i class="fa-solid fa-lock"></i></span> <input
								type="password" id="confirm-password" name="confirmPassword"
								placeholder="Confirm Password" required /> <span
								class="toggle-password"><i class="fa-solid fa-eye"></i></span>
						</div>
					</div>
				</div>
				<p class="password-hint">Use at least 8 characters, including a
					number.</p>

				<div class="checkbox-group">
					<input type="checkbox" id="terms" required /> <label for="terms">I
						agree to the <a href="#">Terms of Service</a> and <a href="#">Privacy
							Policy</a>.
					</label>
				</div>

				<button type="submit" class="btn-action btn-primary">
					Create Account <i class="fa-solid fa-arrow-right-to-bracket"></i>
				</button>
			</form>

			<div class="divider">
				<span>OR</span>
			</div>

			<button type="button" class="btn-action btn-google">
				<img src="assets/icons/google.png" alt="Google Icon" /> Continue
				with Google
			</button>

			<p class="signin-prompt">
				Already have an account? <a href="login.jsp">Sign In</a>
			</p>
		</div>
	</main>
	<footer class="login-footer">
		<p>&copy; 2026 Dhyan, Shared Knowledge, Growing Together.</p>
		<div class="footer-links">
			<a href="#">Privacy Policy</a> <a href="#">Support</a>
		</div>
	</footer>

	<script src="assets/js/ui.js"></script>
	<script src="assets/js/theme.js"></script>
	<script src="assets/js/register.js"></script>
</body>
</html>
