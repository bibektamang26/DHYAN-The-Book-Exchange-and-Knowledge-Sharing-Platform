document.addEventListener("DOMContentLoaded", () => {
  const feed = document.getElementById("post-feed");
  if (!feed) return;

  const loadMoreBtn = document.getElementById("load-more-btn");
  const newPostText = document.getElementById("new-post-text");
  const newPostSubmit = document.getElementById("new-post-submit");

  const VISIBLE_STEP = 5; 
  let visibleCount = VISIBLE_STEP;

  // Track cards as a modifiable let variable so arrays update seamlessly upon deletion
  let postCards = Array.from(feed.querySelectorAll(".post-card"));

  const showToast = (message, type = "success") => {
    if (typeof DHYAN_UI !== "undefined" && typeof DHYAN_UI.toast === "function") {
      DHYAN_UI.toast(message, type);
    } else {
      alert(message);
    }
  };

  const applyVisibility = () => {
    postCards.forEach((card, index) => {
      if (card.hasAttribute("data-new")) {
        card.style.display = "";
      } else {
        card.style.display = index < visibleCount ? "" : "none";
      }
    });

    if (loadMoreBtn) {
      loadMoreBtn.style.display = visibleCount >= postCards.length ? "none" : "";
    }
  };

  const wireShareButton = (card) => {
    const shareBtn = card.querySelector('[data-action="share"]');
    if (!shareBtn) return;

    shareBtn.replaceWith(shareBtn.cloneNode(true));
    const cleanShareBtn = card.querySelector('[data-action="share"]');

    cleanShareBtn.addEventListener("click", () => {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(window.location.href)
          .then(() => showToast("Link copied to clipboard."))
          .catch(() => showToast("Couldn't copy link.", "error"));
      } else {
        const tempInput = document.createElement("input");
        tempInput.value = window.location.href;
        document.body.appendChild(tempInput);
        tempInput.select();
        document.execCommand("copy");
        document.body.removeChild(tempInput);
        showToast("Link copied to clipboard.");
      }
    });
  };

  if (newPostSubmit && newPostText) {
    newPostSubmit.addEventListener("click", () => {
      const text = newPostText.value.trim();
      
      if (!text) {
        showToast("Write something before posting.", "error");
        return;
      }

      newPostSubmit.disabled = true;

      fetch("community", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: `content=${encodeURIComponent(text)}`,
      })
      .then(response => {
        if (!response.ok) {
          throw new Error("Server responded with an error status.");
        }
        newPostText.value = "";
        location.reload();
      })
      .catch(error => {
        console.error("Submission Error:", error);
        showToast("Failed to save post. Please try again.", "error");
      })
      .finally(() => {
        newPostSubmit.disabled = false;
      });
    });
  }

  if (loadMoreBtn) {
    loadMoreBtn.addEventListener("click", () => {
      visibleCount += VISIBLE_STEP;
      applyVisibility();
    });
  }

  // --- POST ACTION MENU & DELETION LOGIC ---
  feed.addEventListener("click", (e) => {
    const menuBtn = e.target.closest('[data-action="post-menu"]');
    if (!menuBtn) return;
    
    const contextMenu = menuBtn.nextElementSibling;
    if (!contextMenu) return;
   
    document.querySelectorAll(".post-context-menu").forEach(menu => {
      if (menu !== contextMenu) menu.style.display = "none";
    });

    contextMenu.style.display = contextMenu.style.display === "none" ? "block" : "none";
    e.stopPropagation();
  });

  document.addEventListener("click", () => {
    document.querySelectorAll(".post-context-menu").forEach(menu => menu.style.display = "none");
  });

  feed.addEventListener("click", (e) => {
    const deleteBtn = e.target.closest(".delete-post-btn");
    if (!deleteBtn) return;

    const postCard = deleteBtn.closest(".post-card");
    const postId = postCard.getAttribute("data-post-id");

    if (!confirm("Are you sure you want to delete this post permanently?")) return;
    fetch("DeletePostServlet", {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: `postID=${encodeURIComponent(postId)}`
    })
    .then(response => {
      if (response.ok) {
        showToast("Post deleted successfully.");
        postCard.remove();
        postCards = Array.from(feed.querySelectorAll(".post-card"));
        applyVisibility();
      } else {
        throw new Error("Deletion failed on server.");
      }
    })
    .catch(error => {
      console.error("Delete Error:", error);
      showToast("Failed to delete post. Try again later.", "error");
    });
  });

  postCards.forEach(wireShareButton);
  applyVisibility();
});
