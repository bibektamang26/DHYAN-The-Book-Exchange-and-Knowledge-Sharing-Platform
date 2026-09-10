<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"
	language="java"%>
<!doctype html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<title>DHYAN</title>
<link rel="icon" type="image/png" href="assets/icons/logo.png" />
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

<link rel="stylesheet" href="assets/css/home.css" />
<link rel="stylesheet" href="assets/css/app.css" />
</head>

<body>
	<div id="navbar">
  <jsp:include page="/components/navbar.jsp" />
</div>

	<main class="main-container">
		<section class="hero">
			<h1>Share Books, Grow Knowledge</h1>
			<div class="text-wrapper">
				<p>Join a community of readers dedicated to lifelong learning.
					Exchange physical books, discover new ideas, and build meaningful
					connections through shared knowledge.</p>
			</div>
			<div class="hero-buttons">
				<button class="get-started">Get Started</button>
				<button class="community">Explore Community</button>
			</div>
		</section>

		<section class="feature-section" id="services">
			<div class="feature-wrapper">
				<div class="feature">
					<div class="icon-container1">
						<i class="fa-solid fa-arrow-right-arrow-left"></i>
					</div>
					<h3>Book Exchange</h3>
					<p>Seamlessly trade books with readers in your area. Keep
						knowledge circulating and reduce waste.</p>
				</div>

				<div class="feature">
					<div class="icon-container2">
						<i class="fa-solid fa-users"></i>
					</div>
					<h3>Vibrant Community</h3>
					<p>Join study groups, book clubs, and discussions. Connect with
						like-minded individuals.</p>
				</div>

				<!-- Feature 3 -->
				<div class="feature">
					<div class="icon-container3">
						<i class="fa-solid fa-graduation-cap"></i>
					</div>
					<h3>Knowledge Sharing</h3>
					<p>Access a wealth of shared notes, reviews, and insights
						curated by our academic community.</p>
				</div>
			</div>
		</section>

		<section class="popular-books" id="books">
			<div class="popular-books-container">
				<div class="heading-container">
					<div class="heading-text">
						<h2>Popular Exchanges</h2>
						<p>Books trending in our community right now.</p>
					</div>
					<button class="view-all">
						<a href="login.jsp">View All <i
							class="fa-solid fa-arrow-right"></i></a>
					</button>
				</div>

				<div class="bookCards-container">
					<div class="card">
						<div class="image-wrapper">
							<img src="assets/images/card1.png" alt="The Book Thief" />
						</div>
						<span class="tag">AVAILABLE</span>
						<div class="book-info">
							<h4>The Book Thief</h4>
							<span class="author">Markus Zusak</span>
							<div class="last">
								<span class="genre">Fiction</span>
								<button>
									<i class="fa-regular fa-bookmark"></i>
								</button>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="image-wrapper">
							<img src="assets/images/card2.png" alt="Thinking, Fast and Slow" />
						</div>
						<span class="tagEx">IN EXCHANGE</span>
						<div class="book-info">
							<h4>Man’s Search for Meaning</h4>
							<span class="author"> Viktor Frankl</span>
							<div class="last">
								<span class="genre">Memoir, Psychology</span>
								<button>
									<i class="fa-regular fa-bookmark"></i>
								</button>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="image-wrapper">
							<img src="assets/images/card3.png" alt="Atomic Habits" />
						</div>
						<span class="tag">AVAILABLE</span>
						<div class="book-info">
							<h4>Atomic Habits</h4>
							<span class="author">James Clear</span>
							<div class="last">
								<span class="genre">Self-Help</span>
								<button>
									<i class="fa-regular fa-bookmark"></i>
								</button>
							</div>
						</div>
					</div>

					<div class="card">
						<div class="image-wrapper">
							<img src="assets/images/card4.png" alt="पल्पसा क्याफे" />
						</div>
						<span class="tag">AVAILABLE</span>
						<div class="book-info">
							<h4>पल्पसा क्याफे</h4>
							<span class="author">Narayan Wagle</span>
							<div class="last">
								<span class="genre">Contemporary Fiction</span>
								<button>
									<i class="fa-regular fa-bookmark"></i>
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>

		<div id="footer">
  <jsp:include page="/components/footer.jsp" />
</div>
	</main>
	
	<script src="assets/js/main.js"></script>
	<script src="assets/js/ui.js"></script>
	<script src="assets/js/index.js"></script>
</body>
</html>
