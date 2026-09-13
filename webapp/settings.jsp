<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN | Settings</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
<script src="assets/js/theme.js"></script>
<script src="assets/js/store.js"></script>
<script src="assets/js/auth.js"></script>

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

<!-- Page css -->
<link rel="stylesheet" href="assets/css/settings.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<div class="layout">
		<div id="sidebar">
			<jsp:include page="/components/sidebar.jsp" />
		</div>

		<main>
			<div class="settings">
				<header class="page-header">
					<h1>Settings</h1>
					<p>Manage your account preferences and application appearance.</p>
				</header>

				<section class="settings-section">
					<h2>
						<i class="fa-solid fa-palette"></i> Appearance
					</h2>

					<div class="appearance-options">
						<button class="appearance-card appearance-card-active"
							data-mode="light">
							<div class="appearance-preview preview-light no-invert">
								<span class="preview-bar"></span> <span class="preview-line"></span>
								<span class="preview-line short"></span>
							</div>
							<h4>Light Mode</h4>
							<p>Default bright interface</p>
						</button>

						<button class="appearance-card" data-mode="dark">
							<div class="appearance-preview preview-dark no-invert">
								<span class="preview-bar"></span> <span class="preview-line"></span>
								<span class="preview-line short"></span>
							</div>
							<h4>Dark Mode</h4>
							<p>Easier on the eyes</p>
						</button>

						<button class="appearance-card" data-mode="system">
							<div class="appearance-preview preview-system no-invert">
								<i class="fa-solid fa-gear"></i>
							</div>
							<h4>System</h4>
							<p>Sync with OS settings</p>
						</button>
					</div>
				</section>

				<section class="settings-section">
					<h2>
						<i class="fa-solid fa-user-gear"></i> Account Settings
					</h2>

					<div class="settings-card">
						<div class="settings-card-header">
							<div>
								<h3>Profile Information</h3>
								<p>Update your public identity on the Dhyan network.</p>
							</div>
							<a href="#" class="link-edit" id="edit-profile-btn">Edit
								details</a>
						</div>

						<div class="profile-fields">
							<img src="assets/images/profile5.png" alt="Bibek"
								class="profile-avatar" data-user-avatar />
							<div class="field-group">
								<label for="display-name">Display Name</label> <input
									type="text" id="display-name" value="Bibek Tamang" readonly />
							</div>
							<div class="field-group">
								<label for="academic-bio">Academic Bio</label> <input
									type="text" id="academic-bio" value="CS student" readonly />
							</div>
						</div>
					</div>

					<div class="settings-columns">
						<div class="settings-card">
							<h3>
								<i class="fa-regular fa-bell"></i> Notifications
							</h3>

							<ul class="toggle-list">
								<li><span>Book Exchange Requests</span>
									<button class="toggle toggle-on" aria-pressed="true"
										data-setting="requests"></button></li>
								<li><span>Community Forum Mentions</span>
									<button class="toggle" aria-pressed="false"
										data-setting="mentions"></button></li>
								<li><span>Lending Overdue Alerts</span>
									<button class="toggle toggle-on" aria-pressed="true"
										data-setting="overdue"></button></li>
							</ul>
						</div>

						<div class="settings-card">
							<h3>
								<i class="fa-solid fa-shield-halved"></i> Security
							</h3>

							<ul class="settings-list">
								<li><a href="#" id="change-password-link"> <span><i
											class="fa-solid fa-key"></i> Change Password</span> <i
										class="fa-solid fa-chevron-right"></i>
								</a></li>
								<li><a href="#" id="two-factor-link"> <span><i
											class="fa-solid fa-mobile-screen"></i> Two-Factor Auth <span
											id="two-factor-status"
											style="color: #94a3b8; font-weight: 400;"></span></span> <i
										class="fa-solid fa-chevron-right"></i>
								</a></li>
								<li><a href="#" class="link-danger" id="deactivate-link">
										<span><i
											class="fa-solid fa-triangle-exclamation"></i> Delete
											Account</span> <i class="fa-solid fa-chevron-right"></i>
								</a></li>
							</ul>
						</div>
					</div>
				</section>

				<footer class="settings-footer">
					<button class="btn-cancel">Cancel</button>
					<button class="btn-save">Save Changes</button>
				</footer>
			</div>
		</main>
	</div>
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/settings.js"></script>
</body>
</html>
