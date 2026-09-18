<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<div class="navbar">
  <nav class="container">
    <div class="brand">
      <img src="assets/icons/logo.png" alt="logo.png" />
      <span class="brand-name">DHYAN</span>
    </div>
    <ul class="nav-links">
      <li>
        <a href="#services" class="nav-item active">Our Services</a>
      </li>
      <li>
        <a href="login" class="nav-item">Community</a>
      </li>
      <li>
        <a href="#books" class="nav-item">Browse Books</a>
      </li>
      <li>
    </ul>
    <div class="nav-actions">
      <button class="notifications">
        <span class="notification-number">1</span>
        <i class="fa-regular fa-bell"></i>
      </button>
      <button
        class="profile"
        onclick="window.location.href = 'login'"
      >
        <i class="fa-regular fa-circle-user"></i>
      </button>
    </div>
  </nav>
</div>
