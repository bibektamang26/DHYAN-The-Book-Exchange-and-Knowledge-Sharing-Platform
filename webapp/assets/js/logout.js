document.addEventListener("DOMContentLoaded", function () {
  if (!window.DHYAN) return;

  // Remember who was signed in so "Continue as ..." still works after
  // the session is cleared below.
  var lastUser = DHYAN.currentUser();
  var profile = DHYAN.getProfile();

  var nameEl = document.querySelector(".btn-continue");
  var name = (profile && (profile.displayName || profile.name)) || "Reader";
  if (nameEl) nameEl.textContent = "Continue with " + name.split(" ")[0];

  // Actually end the session now that the page has loaded.
  DHYAN.logout();

  if (nameEl && lastUser) {
    nameEl.addEventListener("click", function () {
      DHYAN.login(lastUser.email, lastUser.password);
      window.location.href = "dashboard.html";
    });
  } else if (nameEl) {
    nameEl.addEventListener("click", function () {
      window.location.href = "login.html";
    });
  }
});
