document.addEventListener("DOMContentLoaded", function () {
  var getStartedBtn = document.querySelector(".get-started");
  if (getStartedBtn) {
    getStartedBtn.addEventListener("click", function () {
      window.location.href = "register.jsp";
    });
  }

  var communityBtn = document.querySelector(".community");
  if (communityBtn) {
    communityBtn.addEventListener("click", function () {
      window.location.href = "login.jsp";
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
