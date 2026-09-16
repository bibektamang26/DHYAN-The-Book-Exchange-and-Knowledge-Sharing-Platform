<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.dhyan.model.ExchangeRequest" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <title>DHYAN | Requests</title>
    <link rel="icon" type="image/png" href="assets/icons/logo.png" />
    <script src="assets/js/theme.js"></script>

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://googleapis.com" />
    <link rel="preconnect" href="https://gstatic.com" />
    <link href="https://googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Merriweather:wght@400;700&display=swap" rel="stylesheet" />
    <link rel="stylesheet" href="https://cloudflare.com" />

    <!-- Global CSS -->
    <link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" />
    <link rel="stylesheet" href="assets/css/variables.css" />
    <link rel="stylesheet" href="assets/css/components.css" />

    <!-- Page css -->
    <link rel="stylesheet" href="assets/css/requests.css" />
    <link rel="stylesheet" href="assets/css/app.css" />
  </head>

  <body>
    <%
        // Retrieve lists and date formatter using traditional Java initialization scriptlets
        List<ExchangeRequest> receivedList = (List<ExchangeRequest>) request.getAttribute("receivedRequestsList");
        List<ExchangeRequest> sentList = (List<ExchangeRequest>) request.getAttribute("sentRequestsList");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MMM dd, yyyy");
    %>

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
            <a href="#" class="tab tab-active" data-tab="received">Received Requests</a>
            <a href="#" class="tab" data-tab="sent">Sent Requests</a>
          </nav>

          <!-- RECEIVED REQUESTS PANEL  -->
          <section class="request-cards" id="received-panel">
            <% if (receivedList == null || receivedList.isEmpty()) { %>
                <div class="dhyan-empty-state">No received requests yet.</div>
            <% } else { 
                for (ExchangeRequest req : receivedList) { 
                    String status = req.getStatus() != null ? req.getStatus().toLowerCase() : "pending";
                    String displayStatus = status.substring(0, 1).toUpperCase() + status.substring(1);
                    String dateStr = req.getCreatedAt() != null ? dateFormat.format(req.getCreatedAt()) : "";
            %>
                  <div class="request-card">
                    <!-- BOOK COVER -->
                    <div class="request-cover">
                      <img src="<%= request.getContextPath() %>/<%= req.getCoverImagePath() %>" alt="<%= req.getBookTitle() %> cover" />
                    </div>

                    <!-- REQ DETAILS -->
                    <div class="request-details">
                      <div class="request-top-row">
                        <span class="status-badge status-<%= "declined".equals(status) || "cancelled".equals(status) ? "pending" : status %>">
                          <%= displayStatus %>
                        </span>
                        <span class="request-date"><%= dateStr %></span>
                      </div>
                      
                      <h3 class="request-title"><%= req.getBookTitle() %></h3>
                      
                      <hr class="divider" />
                      
                      <div class="request-user">
                        <img src="assets/images/default-avatar.png" class="avatar" alt="<%= req.getSenderName() %>" />
                        <p>
                          <strong><%= req.getSenderName() %></strong> 
                          <%= "completed".equals(status) ? "received this book" : "wants to exchange" %>
                        </p>
                      </div>

                      <div class="request-actions">
                        <% if ("pending".equalsIgnoreCase(status)) { %>
                            <form action="requests" method="POST" style="display:inline;">
                              <input type="hidden" name="requestID" value="<%= req.getRequestID() %>">
                              <input type="hidden" name="statusValue" value="ACCEPTED">
                              <button type="submit" class="btn-accept">Accept</button>
                            </form>
                            <form action="manage-request" method="POST" style="display:inline;">
                              <input type="hidden" name="requestID" value="<%= req.getRequestID() %>">
                              <input type="hidden" name="statusValue" value="DECLINED">
                              <button type="submit" class="btn-decline">Decline</button>
                            </form>
                        <% } else if ("accepted".equalsIgnoreCase(status)) { %>
                            <button type="button" class="btn-message"><i class="fa-regular fa-message"></i> Message</button>
                        <% } else if ("completed".equalsIgnoreCase(status)) { %>
                            <p class="request-note">Exchange completed.</p>
                        <% } else if ("declined".equalsIgnoreCase(status)) { %>
                            <p class="request-note">You declined this request.</p>
                        <% } %>
                      </div>
                    </div>
                  </div>
            <% 
                } 
            } 
            %>
          </section>

          <!--  SENT REQUESTS PANEL -->
          <section class="request-cards" id="sent-panel" style="display: none">
            <% if (sentList == null || sentList.isEmpty()) { %>
                <div class="dhyan-empty-state">You haven't sent any requests yet.</div>
            <% } else { 
                for (ExchangeRequest req : sentList) { 
                    String status = req.getStatus() != null ? req.getStatus().toLowerCase() : "pending";
                    String displayStatus = status.substring(0, 1).toUpperCase() + status.substring(1);
                    String dateStr = req.getCreatedAt() != null ? dateFormat.format(req.getCreatedAt()) : "";
            %>
                  <div class="request-card">
                    <!-- BOOK COVER -->
                    <div class="request-cover">
                      <img src="<%= request.getContextPath() %>/<%= req.getCoverImagePath() %>" alt="<%= req.getBookTitle() %> cover" />
                    </div>

                    <!-- REQ DETAILS -->
                    <div class="request-details">
                      <div class="request-top-row">
                        <span class="status-badge status-<%= "declined".equals(status) || "cancelled".equals(status) ? "pending" : status %>">
                          <%= displayStatus %>
                        </span>
                        <span class="request-date"><%= dateStr %></span>
                      </div>
                      
                      <h3 class="request-title"><%= req.getBookTitle() %></h3>
                      
                      <hr class="divider" />
                      
                      <div class="request-user">
                        <img src="assets/images/default-avatar.png" class="avatar" alt="User" />
                        <p>You requested from <strong><%= req.getReceiverName() %></strong></p>
                      </div>

                      <div class="request-actions">
                        <% if ("pending".equalsIgnoreCase(status)) { %>
                            <form action="requests" method="POST" style="width: 100%;">
                              <input type="hidden" name="requestID" value="<%= req.getRequestID() %>">
                              <input type="hidden" name="statusValue" value="CANCELLED">
                              <button type="submit" class="btn-decline" style="width: 100%;">Cancel Request</button>
                            </form>
                        <% } else if ("cancelled".equalsIgnoreCase(status)) { %>
                            <p class="request-note">You cancelled this request.</p>
                        <% } else { %>
                            <p class="request-note">Status: <%= displayStatus %></p>
                        <% } %>
                      </div>
                    </div>
                  </div>
            <% 
                } 
            } 
            %>
          </section>
        </div>
      </main>
    </div>

    <!-- Frontend Tab Toggling Scripts Sync -->
    <script>
      document.addEventListener("DOMContentLoaded", function () {
        var receivedPanel = document.getElementById("received-panel");
        var sentPanel = document.getElementById("sent-panel");
        if (!receivedPanel || !sentPanel) return;

        var tabs = document.querySelectorAll(".tabs .tab");
        var panels = { received: receivedPanel, sent: sentPanel };

        tabs.forEach(function (tab) {
          tab.addEventListener("click", function (e) {
            e.preventDefault();
            tabs.forEach(function (t) {
              t.classList.remove("tab-active");
            });
            tab.classList.add("tab-active");
            var target = tab.dataset.tab;
            Object.keys(panels).forEach(function (key) {
              panels[key].style.display = key === target ? "grid" : "none";
            });
          });
        });
      });
    </script>

    <script src="assets/js/main.js"></script>
    <script src="assets/js/ui.js"></script>
  </body>
</html>
