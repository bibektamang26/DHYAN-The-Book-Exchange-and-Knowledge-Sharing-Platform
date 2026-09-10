<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>DHYAN | Browse Books</title>
    <link rel="icon" type="image/png" href="assets/icons/logo.png" />
    <script src="assets/js/theme.js"></script>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com"  />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap"
      rel="stylesheet"
    />
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"
    />

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
              <i class="fa-solid fa-magnifying-glass"></i>
              <input
                type="text"
                id="book-search"
                placeholder="Search for books, authors, or ISBN..."
              />
            </div>
          </div>
          <div class="topbar-actions">
            <button class="icon-btn" id="notification">
              <span class="notification-number">1</span
              ><i class="fa-regular fa-bell"></i>
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
              <p class="page-subtitle">
                Discover books shared by your local community.
              </p>
            </div>
            <button class="btn-primary" id="add-book-btn">
              <i class="fa-solid fa-plus"></i> Add a Book
            </button>
          </div>

          <div class="filter-bar">
            <div class="filter-group">
              <select class="filter-dropdown" id="filter-category">
                <option value="all">All Categories</option>
                <option value="self-help">Self-Help</option>
                <option value="fiction">Fiction</option>
                <option value="memoir">Memoir</option>
                <option value="sci-fi">Science Fiction</option>
              </select>

              <select class="filter-dropdown" id="filter-availability">
                <option value="all">Availability</option>
                <option value="available">Available</option>
                <option value="exchanged">Exchanged</option>
              </select>

              <select class="filter-dropdown" id="filter-distance">
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

          <div class="book-grid" id="book-grid">
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img src="assets/images/book1.png" alt="Atomic Habits" />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Self-Help</span>
                <h3 class="book-title">Atomic Habits</h3>
                <p class="book-author">James Clear</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> KTM</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>

            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img src="assets/images/book2.png" alt="सेतो धरती" />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Social Realism Fiction</span>
                <h3 class="book-title">सेतो धरती</h3>
                <p class="book-author">अमर न्यौपाने</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> BKT</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img
                    src="assets/images/book3.png"
                    alt="अन्तरमनको यात्रा"
                  />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge exchanged">Exchanged</span>
              </div>
              <div class="book-info">
                <span class="book-category">Memoir</span>
                <h3 class="book-title">अन्तरमनको यात्रा</h3>
                <p class="book-author">Jagadish Ghimire</p>
                <div class="book-meta">
                  <span class="book-return"
                    ><i class="fa-regular fa-calendar"></i> July 26</span
                  >
                  <a href="#" class="action notitfy">Notify Me</a>
                </div>
              </div>
            </div>
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img src="assets/images/book4.png" alt="कर्नाली ब्लुज" />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Coming-of-Age Drama</span>
                <h3 class="book-title">कर्नाली ब्लुज</h3>
                <p class="book-author">बुद्धिसागर</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> PKH</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>

            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img src="assets/images/book5.png" alt="Dune" />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge exchanged">Exchanged</span>
              </div>
              <div class="book-info">
                <span class="book-category">Science Fiction</span>
                <h3 class="book-title">Dune</h3>
                <p class="book-author">Frank Herbert</p>
                <div class="book-meta">
                  <span class="book-return"
                    ><i class="fa-regular fa-calendar"></i> Oct 12</span
                  >
                  <a href="#" class="action notify">Notify Me</a>
                </div>
              </div>
            </div>
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img
                    src="assets/images/book6.png"
                    alt="Think And Grow Rich"
                  />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Self-Help</span>
                <h3 class="book-title">Think And Grow Rich</h3>
                <p class="book-author">Napolean Hill</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> NWKT</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img
                    src="assets/images/book7.png"
                    alt="Think And Grow Rich"
                  />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Auto-biography</span>
                <h3 class="book-title">Mahabir Pun</h3>
                <p class="book-author">Mahabir Pun</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> CHBL</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>
            <div class="book-card">
              <div class="book-cover">
                <div class="image-wrapper">
                  <img src="assets/images/book8.png" alt="Muna Madan" />
                </div>
                <button class="bookmark-btn">
                  <i class="fa-regular fa-bookmark"></i>
                </button>
                <span class="status-badge available">Available</span>
              </div>
              <div class="book-info">
                <span class="book-category">Lyrical</span>
                <h3 class="book-title">Muna Madan</h3>
                <p class="book-author">Laxmi Prasad Devkota</p>
                <div class="book-meta">
                  <span class="book-distance"
                    ><i class="fa-solid fa-location-dot"></i> LPR</span
                  >
                  <a href="#" class="action request">Request</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </main>
    </div>
	<script src="assets/js/main.js"></script>
    <script src="assets/js/ui.js"></script>
    <script src="assets/js/books.js"></script>
  </body>
</html>
