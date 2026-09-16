document.addEventListener("DOMContentLoaded", function() {
    var grid = document.getElementById("book-grid");
    if (!grid) return;

    var searchInput = document.getElementById("book-search");
    var categoryFilter = document.getElementById("filter-category");
    var availabilityFilter = document.getElementById("filter-availability");
    var distanceFilter = document.getElementById("filter-distance");
    var clearFiltersBtn = document.getElementById("clear-filters-btn");
    var addBookBtn = document.getElementById("add-book-btn");

    function categoryMatches(book, value) {
        if (value === "all") return true;
        var cat = (book.category || "").toLowerCase();
        if (value === "self-help") return cat.indexOf("self-help") !== -1 || cat.indexOf("self help") !== -1;
        if (value === "sci-fi") return cat.indexOf("sci") !== -1;
        return cat.indexOf(value) !== -1;
    }

    function render() {
        var books = DHYAN.getBooks();
        var query = (searchInput && searchInput.value.trim().toLowerCase()) || "";
        var category = (categoryFilter && categoryFilter.value) || "all";
        var availability = (availabilityFilter && availabilityFilter.value) || "all";

        var filtered = books.filter(function(book) {
            if (query) {
                var haystack = (book.title + " " + book.author).toLowerCase();
                if (haystack.indexOf(query) === -1) return false;
            }
            if (!categoryMatches(book, category)) return false;
            if (availability !== "all" && book.status !== availability) return false;
            return true;
        });

        grid.innerHTML = "";

        if (filtered.length === 0) {
            var empty = document.createElement("div");
            empty.className = "dhyan-empty-state";
            empty.textContent = "No books match your search or filters.";
            grid.appendChild(empty);
            return;
        }

        filtered.forEach(function(book) {
            grid.appendChild(renderCard(book));
        });
    }

    function renderCard(book) {
        var card = document.createElement("div");
        card.className = "book-card";

        var bookmarkClass = book.bookmarked
            ? "bookmark-btn dhyan-bookmark-active"
            : "bookmark-btn";
        var bookmarkIcon = book.bookmarked ? "fa-solid" : "fa-regular";

        var statusBadge =
            '<span class="status-badge ' +
            (book.status === "available" ? "available" : "exchanged") +
            '">' +
            (book.status === "available" ? "Available" : "Exchanged") +
            "</span>";

        var actionHtml;
        if (book.status === "available") {
            if (book.requested) {
                actionHtml =
                    '<span class="action dhyan-action-done">Requested</span>';
            } else {
                actionHtml =
                    '<a href="#" class="action request" data-action="request">Request</a>';
            }
        } else {
            actionHtml =
                '<a href="#" class="action notify' +
                (book.notify ? " dhyan-action-done" : "") +
                '" data-action="notify">' +
                (book.notify ? "Notified ✓" : "Notify Me") +
                "</a>";
        }

        var metaHtml =
            book.status === "available"
                ? '<span class="book-distance"><i class="fa-solid fa-location-dot"></i> ' +
                escapeHtml(book.location || "") +
                "</span>"
                : '<span class="book-return"><i class="fa-regular fa-calendar"></i> ' +
                escapeHtml(book.returnDate || "TBD") +
                "</span>";

        card.innerHTML =
            '<div class="book-cover">' +
            '<div class="image-wrapper"><img src="' +
            book.cover +
            '" alt="' +
            escapeHtml(book.title) +
            '" /></div>' +
            '<button class="' +
            bookmarkClass +
            '" data-action="bookmark"><i class="' +
            bookmarkIcon +
            ' fa-bookmark"></i></button>' +
            statusBadge +
            "</div>" +
            '<div class="book-info">' +
            '<span class="book-category">' +
            escapeHtml(book.category || "") +
            "</span>" +
            '<h3 class="book-title">' +
            escapeHtml(book.title) +
            "</h3>" +
            '<p class="book-author">' +
            escapeHtml(book.author) +
            "</p>" +
            '<div class="book-meta">' +
            metaHtml +
            actionHtml +
            "</div>" +
            "</div>";

        card.querySelector('[data-action="bookmark"]').addEventListener("click", function(e) {
            e.preventDefault();
            DHYAN.toggleBookmark(book.id);
            render();
        });

        var actionEl = card.querySelector(
            '[data-action="request"], [data-action="notify"]'
        );
        if (actionEl) {
            actionEl.addEventListener("click", function(e) {
                e.preventDefault();
                if (book.status === "available") {
                    if (book.requested) return;
                    DHYAN.requestBook(book.id);
                    DHYAN_UI.toast("Request sent for \u201c" + book.title + "\u201d.", "success");
                } else {
                    DHYAN.toggleNotify(book.id);
                    DHYAN_UI.toast(
                        book.notify
                            ? "You'll no longer be notified about this title."
                            : "We'll notify you when this book is available."
                    );
                }
                render();
            });
        }

        return card;
    }

    function escapeHtml(str) {
        var div = document.createElement("div");
        div.textContent = str;
        return div.innerHTML;
    }

    [searchInput, categoryFilter, availabilityFilter, distanceFilter].forEach(
        function(el) {
            if (!el) return;
            var evt = el.tagName === "SELECT" ? "change" : "input";
            el.addEventListener(evt, render);
        }
    );

    if (clearFiltersBtn) {
        clearFiltersBtn.addEventListener("click", function() {
            if (searchInput) searchInput.value = "";
            if (categoryFilter) categoryFilter.value = "all";
            if (availabilityFilter) availabilityFilter.value = "all";
            if (distanceFilter) distanceFilter.value = "any";
            render();
        });
    }

    if (addBookBtn) {
        addBookBtn.addEventListener("click", function() {
            DHYAN_UI.openModal({
                title: "Add a Book",
                confirmLabel: "Add Book",
                fields: [
                    { name: "title", label: "Title", type: "text", placeholder: "Book title" },
                    { name: "author", label: "Author", type: "text", placeholder: "Author name" },
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
                    { name: "location", label: "Your Area", type: "text", placeholder: "e.g. KTM" },
                ],
                onConfirm: function(values) {
                    if (!values.title.trim() || !values.author.trim()) {
                        return false;
                    }
                    DHYAN.addBook({
                        title: values.title.trim(),
                        author: values.author.trim(),
                        category: values.category,
                        location: values.location.trim() || "Nearby",
                        status: "available",
                        mine: true,
                    });
                    DHYAN_UI.toast("\u201c" + values.title + "\u201d added to your library.", "success");
                    render();
                },
            });
        });
    }

    render();

    var notifBtn = document.getElementById("notification");
    if (notifBtn) {
        notifBtn.addEventListener("click", function() {
            DHYAN_UI.toast("You have a new exchange request waiting in Requests.");
        });
    }

    var topbarProfileBtn = document.querySelector(".topbar-actions .icon-btn:last-child");
    if (topbarProfileBtn) {
        topbarProfileBtn.addEventListener("click", function() {
            window.location.href = "profile.html";
        });
    }
    actionEl.addEventListener("click", function(e) {
        e.preventDefault();

        // Call Java Servlet via Fetch API
        fetch("RequestServlet", {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded" },
            body: "action=create&bookId=" + book.id
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    DHYAN.requestBook(book.id);
                    DHYAN_UI.toast("Request sent for “" + book.title + "”.", "success");
                    render();
                } else {
                    DHYAN_UI.toast(data.message || "Failed to send request.", "error");
                }
            })
            .catch(err => DHYAN_UI.toast("Network error occurred.", "error"));
  });
});
