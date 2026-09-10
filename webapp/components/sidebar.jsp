<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<aside class="sidebar">
  <div class="sidebar-logo">
    <img src="assets/icons/logo.png" alt="logo.png" />
    <div class="logo-text">
      <h1 class="logo-title">DHYAN</h1>
      <span class="logo-subtitle">Book Exchange</span>
    </div>
  </div>

  <div class="navigation">
    <nav class="sidebar-nav">
      <a href="dashboard.jsp" class="nav-item" data-page="dashboard">
        <i class="fa-solid fa-chart-simple"></i>
        <span>Dashboard</span>
      </a>
      <a href="books.jsp" class="nav-item" data-page="books">
        <i class="fa-solid fa-book-open"></i>
        <span>Browse Books</span>
      </a>
      <a href="requests.jsp" class="nav-item" data-page="requests">
        <i class="fa-solid fa-right-left"></i>
        <span>Requests</span>
      </a>
      <a href="community.jsp" class="nav-item" data-page="community">
        <i class="fa-solid fa-users"></i>
        <span>Community</span>
      </a>
      <a href="profile.jsp" class="nav-item" data-page="profile">
        <i class="fa-solid fa-user"></i>
        <span>Profile</span>
      </a>
    </nav>

    <div class="sidebar-footer">
      <a href="settings.jsp" class="nav-item" data-page="settings">
        <i class="fa-solid fa-gear"></i>
        <span>Settings</span>
      </a>
      <a href="logout.jsp" class="nav-item" data-page="logout">
        <i class="fa-solid fa-right-from-bracket"></i>
        <span>Logout</span>
      </a>
    </div>
  </div>
</aside>
