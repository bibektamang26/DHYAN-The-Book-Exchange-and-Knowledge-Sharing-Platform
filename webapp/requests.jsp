<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>DHYAN | Requests</title>
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

    <!-- Page css -->
    <link rel="stylesheet" href="assets/css/requests.css" />
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>

  <body>
    <div class="layout">
      <div id="sidebar">
  <jsp:include page="/components/sidebar.jsp" />
</div>

      <main>
        <div class="exchange-requests">
          <header class="page-header">
            <h1>Exchange Requests</h1>
          </header>
          <nav class="tabs">
            <a href="#" class="tab tab-active" data-tab="received"
              >Received Requests</a
            >
            <a href="#" class="tab" data-tab="sent">Sent Requests</a>
          </nav>

          <section class="request-cards" id="received-panel"></section>

          <section class="request-cards" id="sent-panel" style="display: none"></section>
        </div>
      </main>
    </div>
    <script src="assets/js/main.js"></script>
    <script src="assets/js/ui.js"></script>
    <script src="assets/js/requests.js"></script>
  </body>
</html>
