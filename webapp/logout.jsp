<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>DHYAN | Logout</title>
    <link rel="icon" type="image/png" href="assets/icons/logo.png" />
    <script src="assets/js/theme.js"></script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
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

    <!-- page css -->
    <link rel="stylesheet" href="assets/css/logout.css" />
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>

  <body>
    <div class="layout">
      <main>
        <div class="auth-card">
          <img
            src="assets/icons/logo.png"
            alt="DHYAN logo"
            class="auth-logo"
          />

          <h1 class="auth-title">Log back In</h1>

          <div class="auth-avatar">
            <img src="assets/images/profileM.jpeg" alt="Alexander" />
          </div>

          <button class="btn-continue">Continue with Bibek</button>

          <div class="auth-links">
            <a href="login.jsp">Switch Account</a>
            <a href="register.jsp">Create new account</a>
          </div>

          <footer class="auth-footer">
            <p>
              Need help accessing your books? Contact our support team for
              assistance with academic exchange requests.
            </p>
          </footer>
        </div>
      </main>
    </div>
    <div id="footer"></div>
    <script src="assets/js/store.js"></script>
    <script src="assets/js/main.js"></script>
    <script src="assets/js/logout.js"></script>
  </body>
</html>
