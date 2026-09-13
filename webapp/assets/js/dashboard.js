document.addEventListener("DOMContentLoaded", function() {
    var dashboard = document.querySelector(".dashboard");
    if (!dashboard) return;

    // 1. View All redirection route wire-up
    var viewAllLink = document.querySelector(".recommended-section .view-all-link");
    if (viewAllLink) {
        viewAllLink.addEventListener("click", function(e) {
            e.preventDefault();
            window.location.href = "BrowseBooksServlet"; // Routes directly to your Servlet controller
        });
    }

    // 2. Open Add Book Pop-Up Modal
    var addBookBtn = document.querySelector(".btn-add-book");
    if (addBookBtn) {
        addBookBtn.addEventListener("click", function() {
            var modal = document.getElementById("addBookModal");
            if (modal) {
                modal.style.display = "flex"; // Toggles your pop-up modal to appear smoothly
            }
        });
    }

    // 3. Discussion redirect routing 
    var discussionBtn = document.querySelector(".btn-start-discussion");
    if (discussionBtn) {
        discussionBtn.addEventListener("click", function() {
            window.location.href = "community.jsp";
        });
    }
});

// Global functions to close the pop-up modal window safely
function closeBookModal() {
    var modal = document.getElementById("addBookModal");
    if (modal) {
        modal.style.display = "none";
        document.getElementById("realBookForm").reset(); // Resets input rows for next opening
    }
}
