document.addEventListener("DOMContentLoaded", function () {
  var page = document.querySelector(".profile-page");
  if (!page) return;

  function escapeHtml(str) {
    var div = document.createElement("div");
    div.textContent = str || "";
    return div.innerHTML;
  }

  // Load profile
  var nameEl = document.getElementById("profile-name");
  var bioEl = document.getElementById("profile-bio");
  var interestsContainer = document.getElementById("interests-container");
  var statBooksShared = document.getElementById("stat-books-shared");
  var statExchanges = document.getElementById("stat-exchanges");

  function renderProfile() {
    var profile = DHYAN.getProfile();
    nameEl.textContent = (
      profile.displayName ||
      profile.name ||
      "Reader"
    ).split(" ")[0];
    bioEl.textContent = profile.bio || "";

    interestsContainer.innerHTML = "";
    (profile.interests || []).forEach(function (tag) {
      var span = document.createElement("span");
      span.className = "tag";
      span.textContent = tag;
      interestsContainer.appendChild(span);
    });

    var myBooks = DHYAN.getMyBooks();
    if (statBooksShared) statBooksShared.textContent = myBooks.length;
    if (statExchanges) {
      var requests = DHYAN.getRequests();
      var completed = requests.filter(function (r) {
        return r.status === "completed";
      }).length;
      statExchanges.textContent = completed;
    }
  }

  //  Edit profile mode
  var editBtn = document.getElementById("edit-profile-toggle");
  var editing = false;

  if (editBtn) {
    editBtn.addEventListener("click", function () {
      editing = !editing;

      if (editing) {
        var profile = DHYAN.getProfile();
        var nameInput = document.createElement("input");
        nameInput.type = "text";
        nameInput.value = profile.displayName || profile.name || "";
        nameInput.id = "profile-name-input";
        nameInput.style.font = "inherit";
        nameInput.style.fontFamily = "Merriweather, serif";
        nameInput.style.fontWeight = "700";
        nameInput.style.border = "1px solid #e2e8f0";
        nameInput.style.borderRadius = "4px";
        nameInput.style.padding = "2px 6px";
        nameEl.replaceWith(nameInput);

        var bioInput = document.createElement("input");
        bioInput.type = "text";
        bioInput.value = profile.bio || "";
        bioInput.id = "profile-bio-input";
        bioInput.style.font = "inherit";
        bioInput.style.border = "1px solid #e2e8f0";
        bioInput.style.borderRadius = "4px";
        bioInput.style.padding = "2px 6px";
        bioInput.style.width = "100%";
        bioEl.replaceWith(bioInput);

        editBtn.innerHTML = '<i class="fa-solid fa-check"></i> Done Editing';
      } else {
        var nameInputEl = document.getElementById("profile-name-input");
        var bioInputEl = document.getElementById("profile-bio-input");
        var newName = nameInputEl ? nameInputEl.value.trim() : "";
        var newBio = bioInputEl ? bioInputEl.value.trim() : "";

        var current = DHYAN.getProfile();
        DHYAN.updateProfile({
          displayName: newName || current.displayName,
          name: newName || current.name,
          bio: newBio,
        });

        if (nameInputEl) nameInputEl.replaceWith(nameEl);
        if (bioInputEl) bioInputEl.replaceWith(bioEl);

        editBtn.innerHTML = '<i class="fa-solid fa-pencil"></i> Edit Profile';
        renderProfile();
        DHYAN_UI.toast("Profile updated.", "success");
      }
    });
  }

  //  My Books grid
  var grid = document.getElementById("my-books-grid");
  var filterBtn = document.getElementById("my-books-filter");
  var filterStates = ["all", "available", "lent"];
  var filterLabels = { all: "All", available: "Available", lent: "Lent Out" };
  var filterIndex = 0;

  function renderMyBooks() {
    var books = DHYAN.getMyBooks();
    var filter = filterStates[filterIndex];
    var filtered = books.filter(function (b) {
      return filter === "all" || b.status === filter;
    });

    grid.innerHTML = "";

    filtered.forEach(function (book) {
      var item = document.createElement("div");
      item.className = "book-item";
      var badgeClass =
        book.status === "available" ? "badge-available" : "badge-lent";
      var badgeText = book.status === "available" ? "AVAILABLE" : "LENT OUT";
      item.innerHTML =
        '<div class="book-cover"><img src="' +
        book.cover +
        '" alt="' +
        escapeHtml(book.title) +
        '" style="width:100%;height:100%;object-fit:cover;" /></div>' +
        '<div class="book-title">' +
        escapeHtml(book.title) +
        "</div>" +
        '<div class="book-author">' +
        escapeHtml(book.author) +
        "</div>" +
        '<span class="badge ' +
        badgeClass +
        '">' +
        badgeText +
        "</span>";
      grid.appendChild(item);
    });

    var addItem = document.createElement("div");
    addItem.className = "book-item";
    addItem.innerHTML =
      '<div class="add-book-card" id="add-my-book-card">' +
      '<div class="add-icon"><i class="fa-solid fa-plus"></i></div>' +
      '<div class="add-text">Add Book</div>' +
      "</div>";
    grid.appendChild(addItem);

    document
      .getElementById("add-my-book-card")
      .addEventListener("click", openAddBookModal);

    if (statBooksShared) statBooksShared.textContent = books.length;
  }

  function openAddBookModal() {
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
          name: "status",
          label: "Status",
          type: "select",
          options: [
            { value: "available", label: "Available" },
            { value: "lent", label: "Lent Out" },
          ],
        },
      ],
      onConfirm: function (values) {
        if (!values.title.trim() || !values.author.trim()) return false;
        DHYAN.addMyBook({
          title: values.title.trim(),
          author: values.author.trim(),
          status: values.status,
        });
        DHYAN_UI.toast(
          "\u201c" + values.title + "\u201d added to My Books.",
          "success"
        );
        renderMyBooks();
      },
    });
  }

  if (filterBtn) {
    filterBtn.addEventListener("click", function () {
      filterIndex = (filterIndex + 1) % filterStates.length;
      filterBtn.innerHTML =
        '<span class="filter-icon"><i class="fa-solid fa-bars" style="color: #244ea2;"></i></span> Filter: ' +
        filterLabels[filterStates[filterIndex]];
      renderMyBooks();
    });
  }

  renderProfile();
  renderMyBooks();
});
