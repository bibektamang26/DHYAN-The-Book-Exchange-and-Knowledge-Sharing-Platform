document.addEventListener("DOMContentLoaded", function () {
  var getStartedBtn = document.querySelector(".get-started");
  if (getStartedBtn) {
    getStartedBtn.addEventListener("click", function () {
      window.location.href =
        window.DHYAN && DHYAN.isLoggedIn() ? "dashboard.html" : "register.html";
    });
  }

  var communityBtn = document.querySelector(".community");
  if (communityBtn) {
    communityBtn.addEventListener("click", function () {
      window.location.href =
        window.DHYAN && DHYAN.isLoggedIn() ? "community.html" : "login.html";
    });
  }

  var viewAllBtn = document.querySelector(".view-all");
  if (viewAllBtn) {
    viewAllBtn.addEventListener("click", function (e) {
      e.preventDefault();
      window.location.href =
        window.DHYAN && DHYAN.isLoggedIn() ? "books.html" : "login.html";
    });
  }

  document.querySelectorAll(".bookCards-container .card").forEach(function (card) {
    var bookmarkBtn = card.querySelector(".book-info .last button");
    if (!bookmarkBtn) return;
    var icon = bookmarkBtn.querySelector("i");
    var bookmarked = false;
    bookmarkBtn.addEventListener("click", function () {
      bookmarked = !bookmarked;
      icon.classList.toggle("fa-regular", !bookmarked);
      icon.classList.toggle("fa-solid", bookmarked);
      var title = card.querySelector("h4").textContent;
      if (window.DHYAN_UI) {
        DHYAN_UI.toast(bookmarked ? "Bookmarked \u201c" + title + "\u201d." : "Removed bookmark.");
      }
    });
  });
});
