document.addEventListener("DOMContentLoaded", function () {
  var dashboard = document.querySelector(".dashboard");
  if (!dashboard) return;

  function escapeHtml(str) {
    var div = document.createElement("div");
    div.textContent = str || "";
    return div.innerHTML;
  }

  // Greeting
  var headerText = document.querySelector(".dashboard-header .header-text h1");
  if (headerText) {
    var profile = DHYAN.getProfile();
    var firstName = (profile.displayName || profile.name || "Reader").split(
      " "
    )[0];
    var hour = new Date().getHours();
    var greeting =
      hour < 12
        ? "Good morning"
        : hour < 18
          ? "Good afternoon"
          : "Good evening";
    headerText.textContent = greeting + ", " + firstName + ".";
  }

  // Stats
  function renderStats() {
    var books = DHYAN.getBooks();
    var requests = DHYAN.getRequests();
    var profile = DHYAN.getProfile();

    var activeRequests = requests.filter(function (r) {
      return r.status === "pending" || r.status === "accepted";
    }).length;

    var statValues = document.querySelectorAll(".stats-cards .stat-value");
    if (statValues[0]) statValues[0].textContent = activeRequests;
    if (statValues[1]) statValues[1].textContent = books.length;
    if (statValues[2])
      statValues[2].textContent = (profile.points || 0).toLocaleString();
  }

  // Recommended books (bookmark wiring)
  function renderRecommended() {
    var container = document.querySelector(".recommended-section .book-cards");
    if (!container) return;
    var books = DHYAN.getBooks().slice(0, 3);
    if (books.length === 0) return;

    container.innerHTML = "";
    books.forEach(function (book) {
      var card = document.createElement("div");
      card.className = "book-card";
      var tag =
        book.status === "available"
          ? '<span class="tag tag-available">Available</span>'
          : '<span class="tag tag-exchange">Exchange</span>';
      card.innerHTML =
        '<div class="book-cover">' +
        tag +
        '<img src="' +
        book.cover +
        '" alt="' +
        escapeHtml(book.title) +
        ' cover" />' +
        "</div>" +
        '<h3 class="book-title">' +
        escapeHtml(book.title) +
        "</h3>" +
        '<p class="book-author">' +
        escapeHtml(book.author) +
        "</p>" +
        '<span class="tag tag-genre">' +
        escapeHtml(book.category || "") +
        "</span>";
      card.addEventListener("click", function () {
        window.location.href = "books.html";
      });
      card.style.cursor = "pointer";
      container.appendChild(card);
    });
  }

  var viewAllLink = document.querySelector(
    ".recommended-section .view-all-link"
  );
  if (viewAllLink) {
    viewAllLink.addEventListener("click", function (e) {
      e.preventDefault();
      window.location.href = "books.html";
    });
  }

  // Recent activity: wired to the first pending received request
  function renderActivity() {
    var item = document.querySelector(".activity-list .activity-item");
    if (!item) return;

    var acceptBtn = item.querySelector(".btn-accept");
    var declineBtn = item.querySelector(".btn-decline");
    if (!acceptBtn || !declineBtn) return;

    var requests = DHYAN.getRequests();
    var pending = requests.filter(function (r) {
      return r.direction === "received" && r.status === "pending";
    })[0];

    if (!pending) {
      item.querySelector(".activity-actions").innerHTML =
        '<span style="font-size:12px;color:#94a3b8;">No pending requests</span>';
      return;
    }

    acceptBtn.addEventListener("click", function () {
      DHYAN.updateRequest(pending.id, { status: "accepted" });
      DHYAN_UI.toast(
        'Accepted request for "' + pending.title + '".',
        "success"
      );
      item.querySelector(".activity-actions").innerHTML =
        '<span style="font-size:12px;color:#22c55e;">Accepted</span>';
      renderStats();
    });

    declineBtn.addEventListener("click", function () {
      DHYAN.updateRequest(pending.id, { status: "declined" });
      DHYAN_UI.toast('Declined request for "' + pending.title + '".');
      item.querySelector(".activity-actions").innerHTML =
        '<span style="font-size:12px;color:#94a3b8;">Declined</span>';
      renderStats();
    });
  }

  // Add book / start discussion buttons
  var addBookBtn = document.querySelector(".btn-add-book");
  if (addBookBtn) {
    addBookBtn.addEventListener("click", function () {
      DHYAN_UI.openModal({
        title: "Add a Book",
        confirmLabel: "Add Book",
        fields: [
          {
            name: "title",
            label: "Title",
            type: "text",
            placeholder: "Book title",
          },
          {
            name: "author",
            label: "Author",
            type: "text",
            placeholder: "Author name",
          },
          {
            name: "category",
            label: "Category",
            type: "select",
            options: [
              { value: "Self-Help", label: "Self-Help" },
              { value: "Fiction", label: "Fiction" },
              { value: "Memoir", label: "Memoir" },
              { value: "Science Fiction", label: "Science Fiction" },
              { value: "Other", label: "Other" },
            ],
          },
          {
            name: "location",
            label: "Your Area",
            type: "text",
            placeholder: "e.g. KTM",
          },
        ],
        onConfirm: function (values) {
          if (!values.title.trim() || !values.author.trim()) return false;
          DHYAN.addBook({
            title: values.title.trim(),
            author: values.author.trim(),
            category: values.category,
            location: values.location.trim() || "Nearby",
            status: "available",
            mine: true,
          });
          DHYAN_UI.toast(
            "\u201c" + values.title + "\u201d added to your library.",
            "success"
          );
          renderStats();
          renderRecommended();
        },
      });
    });
  }

  var discussionBtn = document.querySelector(".btn-start-discussion");
  if (discussionBtn) {
    discussionBtn.addEventListener("click", function () {
      window.location.href = "community.html";
    });
  }

  renderStats();
  renderRecommended();
  renderActivity();
});
