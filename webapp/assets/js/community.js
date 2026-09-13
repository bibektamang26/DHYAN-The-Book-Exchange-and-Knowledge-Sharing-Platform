document.addEventListener("DOMContentLoaded", function () {
  var feed = document.getElementById("post-feed");
  if (!feed) return;

  var VISIBLE_STEP = 2;
  var visibleCount = VISIBLE_STEP;

  function escapeHtml(str) {
    var div = document.createElement("div");
    div.textContent = str || "";
    return div.innerHTML;
  }

  function renderPostCard(post) {
    var article = document.createElement("article");
    article.className = "post-card";

    var titleHtml = post.title
      ? '<h3 class="post-title">' + escapeHtml(post.title) + "</h3>"
      : "";

    var bookHtml = "";
    if (post.book) {
      bookHtml =
        '<div class="post-book">' +
        '<img src="' +
        post.book.cover +
        '" alt="' +
        escapeHtml(post.book.title) +
        ' cover" class="post-book-cover" />' +
        '<div class="post-book-info">' +
        "<h5>" +
        escapeHtml(post.book.title) +
        "</h5>" +
        "<p>" +
        escapeHtml(post.book.author) +
        "</p>" +
        '<span class="tag-exchange">Available for Exchange</span>' +
        "</div></div>";
    }

    var tagsHtml = (post.tags || [])
      .map(function (t) {
        return '<span class="tag">' + escapeHtml(t) + "</span>";
      })
      .join("");

    var heartClass = post.liked ? "fa-solid" : "fa-regular";

    article.innerHTML =
      '<div class="post-header">' +
      '<img src="' +
      post.avatar +
      '" alt="' +
      escapeHtml(post.author) +
      '" class="avatar" />' +
      '<div class="post-author-info">' +
      "<h4>" +
      escapeHtml(post.author) +
      "</h4>" +
      "<p>" +
      escapeHtml(post.time) +
      " &middot; " +
      escapeHtml(post.role || "") +
      "</p>" +
      "</div>" +
      '<button class="btn-more" data-action="more"><i class="fa-solid fa-ellipsis"></i></button>' +
      '<div class="dhyan-post-menu dhyan-hidden" data-post-menu>' +
      '<button type="button" data-action="delete"><i class="fa-solid fa-trash"></i> Delete Post</button>' +
      "</div>" +
      "</div>" +
      titleHtml +
      '<p class="post-text">' +
      escapeHtml(post.text) +
      "</p>" +
      bookHtml +
      '<div class="post-tags">' +
      tagsHtml +
      "</div>" +
      '<div class="post-footer">' +
      '<div class="post-stats">' +
      '<span class="like-btn" data-action="like" style="cursor:pointer;"><i class="' +
      heartClass +
      ' fa-heart"></i> <span class="like-count">' +
      post.likes +
      "</span></span>" +
      '<button data-action="comments"><i class="fa-regular fa-message"></i> ' +
      post.comments.length +
      " Comments</button>" +
      "</div>" +
      '<button class="icon-btn" data-action="share"><i class="fa-solid fa-share-nodes"></i></button>' +
      "</div>" +
      '<div class="dhyan-comment-box dhyan-hidden" data-comments></div>';

    var likeEl = article.querySelector('[data-action="like"]');
    likeEl.addEventListener("click", function () {
      DHYAN.toggleLike(post.id);
      render();
    });

    var moreBtn = article.querySelector('[data-action="more"]');
    var postMenu = article.querySelector("[data-post-menu]");
    moreBtn.addEventListener("click", function (e) {
      e.stopPropagation();
      // close any other open menus first
      document.querySelectorAll("[data-post-menu]").forEach(function (m) {
        if (m !== postMenu) m.classList.add("dhyan-hidden");
      });
      postMenu.classList.toggle("dhyan-hidden");
    });

    var deleteBtn = article.querySelector('[data-action="delete"]');
    deleteBtn.addEventListener("click", function () {
      var confirmed = DHYAN_UI.confirm(
        "Delete this post? This can't be undone."
      );
      if (!confirmed) return;
      DHYAN.deletePost(post.id);
      DHYAN_UI.toast("Post deleted.");
      render();
    });

    var commentsBox = article.querySelector("[data-comments]");
    var commentsToggle = article.querySelector('[data-action="comments"]');
    commentsToggle.addEventListener("click", function () {
      commentsBox.classList.toggle("dhyan-hidden");
      if (commentsBox.classList.contains("dhyan-hidden")) return;

      commentsBox.innerHTML = "";
      var list = document.createElement("ul");
      list.className = "dhyan-comment-list";
      post.comments.forEach(function (c) {
        var li = document.createElement("li");
        li.innerHTML =
          "<strong>" +
          escapeHtml(c.author) +
          ":</strong> " +
          escapeHtml(c.text);
        list.appendChild(li);
      });
      commentsBox.appendChild(list);

      var form = document.createElement("div");
      form.className = "dhyan-comment-form";
      form.innerHTML =
        '<input type="text" placeholder="Write a comment..." />' +
        '<button type="button">Send</button>';
      var input = form.querySelector("input");
      var sendBtn = form.querySelector("button");
      function submitComment() {
        var text = input.value.trim();
        if (!text) return;
        DHYAN.addComment(post.id, text);
        render();
      }
      sendBtn.addEventListener("click", submitComment);
      input.addEventListener("keydown", function (e) {
        if (e.key === "Enter") submitComment();
      });
      commentsBox.appendChild(form);
    });

    var shareEl = article.querySelector('[data-action="share"]');
    shareEl.addEventListener("click", function () {
      if (navigator.clipboard) {
        navigator.clipboard
          .writeText(window.location.href)
          .then(function () {
            DHYAN_UI.toast("Link copied to clipboard.");
          })
          .catch(function () {
            DHYAN_UI.toast("Couldn't copy the link.", "error");
          });
      } else {
        DHYAN_UI.toast("Link copied to clipboard.");
      }
    });

    return article;
  }

  function render() {
    var posts = DHYAN.getPosts();
    feed.innerHTML = "";
    posts.slice(0, visibleCount).forEach(function (post) {
      feed.appendChild(renderPostCard(post));
    });

    var loadMoreBtn = document.getElementById("load-more-btn");
    if (loadMoreBtn) {
      loadMoreBtn.style.display = visibleCount >= posts.length ? "none" : "";
    }
  }

  //  New post
  var newPostText = document.getElementById("new-post-text");
  var newPostSubmit = document.getElementById("new-post-submit");

  if (newPostSubmit) {
    newPostSubmit.addEventListener("click", function () {
      var text = (newPostText.value || "").trim();
      if (!text) {
        DHYAN_UI.toast("Write something before posting.", "error");
        return;
      }
      fetch("/addPost", {
        method: "POST",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: "text=" + encodeURIComponent(text), 
      })
        .then(function (response) {
          if (!response.ok) {
            throw new Error("Network response was not ok");
          }
          return response.text(); 
        })
        .then(function (data) {
          newPostText.value = "";
          visibleCount += 1;
          DHYAN_UI.toast("Your post is live.", "success");
          render();
        })
        .catch(function (error) {
          console.error("Error:", error);
          DHYAN_UI.toast("Failed to save post. Try again.", "error");
        });

    });
  }


  //  Load more
  var loadMoreBtn = document.getElementById("load-more-btn");
  if (loadMoreBtn) {
    loadMoreBtn.addEventListener("click", function () {
      visibleCount += VISIBLE_STEP;
      render();
    });
  }

  //  Follow buttons
  document.querySelectorAll(".follow-btn").forEach(function (btn) {
    var following = false;
    btn.addEventListener("click", function () {
      following = !following;
      btn.innerHTML = following
        ? '<i class="fa-solid fa-user-check"></i>'
        : '<i class="fa-solid fa-user-plus"></i>';
      btn.style.color = following ? "#22c55e" : "";
      var name = btn
        .closest("li")
        .querySelector(".contributor-name").textContent;
      DHYAN_UI.toast(
        following ? "Following " + name + "." : "Unfollowed " + name + "."
      );
    });
  });

  document.addEventListener("click", function () {
    document.querySelectorAll("[data-post-menu]").forEach(function (m) {
      m.classList.add("dhyan-hidden");
    });
  });

  render();
});
