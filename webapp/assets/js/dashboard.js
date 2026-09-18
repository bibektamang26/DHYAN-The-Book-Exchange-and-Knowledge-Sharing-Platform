document.addEventListener("DOMContentLoaded", function() {
    var dashboard = document.querySelector(".dashboard");
    if (!dashboard) return;

    var viewAllLink = document.querySelector(".recommended-section .view-all-link");
    if (viewAllLink) {
        viewAllLink.addEventListener("click", function(e) {
            e.preventDefault();
            window.location.href = "BrowseBooksServlet"; 
        });
    }

    var addBookBtn = document.querySelector(".btn-add-book");
    if (addBookBtn) {
        addBookBtn.addEventListener("click", function() {
            var modal = document.getElementById("addBookModal");
            if (modal) {
                modal.style.display = "flex";
            }
        });
    }

    var discussionBtn = document.querySelector(".btn-start-discussion");
    if (discussionBtn) {
        discussionBtn.addEventListener("click", function() {
            window.location.href = "community.jsp";
        });
    }
});

function closeBookModal() {
    var modal = document.getElementById("addBookModal");
    if (modal) {
        modal.style.display = "none";
        document.getElementById("realBookForm").reset();
    }
}
