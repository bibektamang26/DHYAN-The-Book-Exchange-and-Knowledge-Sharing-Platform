document.addEventListener("DOMContentLoaded", function () {
  var receivedPanel = document.getElementById("received-panel");
  var sentPanel = document.getElementById("sent-panel");
  if (!receivedPanel || !sentPanel) return;

  var tabs = document.querySelectorAll(".tab");
  var panels = { received: receivedPanel, sent: sentPanel };

  tabs.forEach(function (tab) {
    tab.addEventListener("click", function (e) {
      e.preventDefault();
      tabs.forEach(function (t) {
        t.classList.remove("tab-active");
      });
      tab.classList.add("tab-active");
      var target = tab.dataset.tab;
      Object.keys(panels).forEach(function (key) {
        panels[key].style.display = key === target ? "grid" : "none";
      });
    });
  });

  function escapeHtml(str) {
    var div = document.createElement("div");
    div.textContent = str || "";
    return div.innerHTML;
  }

  function statusBadgeClass(status) {
    return (
      "status-badge status-" +
      (status === "declined" || status === "cancelled" ? "pending" : status)
    );
  }

  function statusLabel(status) {
    var map = {
      pending: "Pending",
      accepted: "Accepted",
      completed: "Completed",
      declined: "Declined",
      cancelled: "Cancelled",
    };
    return map[status] || status;
  }

  function renderReceivedCard(req) {
    var card = document.createElement("div");
    card.className = "request-card";

    var actionsHtml = "";
    if (req.status === "pending") {
      actionsHtml =
        '<div class="request-actions">' +
        '<button class="btn-accept" data-action="accept">Accept</button>' +
        '<button class="btn-decline" data-action="decline">Decline</button>' +
        "</div>";
    } else if (req.status === "accepted") {
      actionsHtml =
        '<button class="btn-message" data-action="message">' +
        '<i class="fa-regular fa-message"></i> Message</button>';
    } else if (req.status === "completed") {
      actionsHtml =
        '<p class="request-note">' + escapeHtml(req.note || "Exchange completed.") + "</p>";
    } else if (req.status === "declined") {
      actionsHtml = '<p class="request-note">You declined this request.</p>';
    }

    card.innerHTML =
      '<div class="request-cover"><img src="' +
      req.cover +
      '" alt="' +
      escapeHtml(req.title) +
      ' cover" /></div>' +
      '<div class="request-details">' +
      '<div class="request-top-row">' +
      '<span class="' +
      statusBadgeClass(req.status) +
      '">' +
      statusLabel(req.status) +
      "</span>" +
      '<span class="request-date">' +
      escapeHtml(req.date) +
      "</span>" +
      "</div>" +
      '<h3 class="request-title">' +
      escapeHtml(req.title) +
      "</h3>" +
      '<p class="request-author">' +
      escapeHtml(req.author) +
      "</p>" +
      '<hr class="divider" />' +
      '<div class="request-user">' +
      '<img src="' +
      req.avatar +
      '" alt="' +
      escapeHtml(req.person) +
      '" class="avatar" />' +
      "<p><strong>" +
      escapeHtml(req.person) +
      "</strong> " +
      (req.status === "completed" ? "received this book" : "wants to exchange") +
      "</p>" +
      "</div>" +
      actionsHtml +
      "</div>";

    var acceptBtn = card.querySelector('[data-action="accept"]');
    if (acceptBtn) {
      acceptBtn.addEventListener("click", function () {
        DHYAN.updateRequest(req.id, { status: "accepted" });
        DHYAN_UI.toast('Accepted request for "' + req.title + '".', "success");
        renderAll();
      });
    }
    var declineBtn = card.querySelector('[data-action="decline"]');
    if (declineBtn) {
      declineBtn.addEventListener("click", function () {
        DHYAN.updateRequest(req.id, { status: "declined" });
        DHYAN_UI.toast('Declined request for "' + req.title + '".');
        renderAll();
      });
    }
    var messageBtn = card.querySelector('[data-action="message"]');
    if (messageBtn) {
      messageBtn.addEventListener("click", function () {
        DHYAN_UI.toast(
          "Messaging isn't available in this offline demo yet."
        );
      });
    }

    return card;
  }

  function renderSentCard(req) {
    var card = document.createElement("div");
    card.className = "request-card";

    var actionHtml = "";
    if (req.status === "pending") {
      actionHtml =
        '<button class="btn-decline" data-action="cancel">Cancel Request</button>';
    } else if (req.status === "cancelled") {
      actionHtml = '<p class="request-note">You cancelled this request.</p>';
    } else {
      actionHtml =
        '<p class="request-note">' +
        (req.note || "Status: " + statusLabel(req.status)) +
        "</p>";
    }

    card.innerHTML =
      '<div class="request-cover"><img src="' +
      req.cover +
      '" alt="' +
      escapeHtml(req.title) +
      ' cover" /></div>' +
      '<div class="request-details">' +
      '<div class="request-top-row">' +
      '<span class="' +
      statusBadgeClass(req.status) +
      '">' +
      statusLabel(req.status) +
      "</span>" +
      '<span class="request-date">' +
      escapeHtml(req.date) +
      "</span>" +
      "</div>" +
      '<h3 class="request-title">' +
      escapeHtml(req.title) +
      "</h3>" +
      '<p class="request-author">' +
      escapeHtml(req.author) +
      "</p>" +
      '<hr class="divider" />' +
      '<div class="request-user">' +
      '<img src="' +
      req.avatar +
      '" alt="User" class="avatar" />' +
      "<p>You requested from <strong>" +
      escapeHtml(req.person) +
      "</strong></p>" +
      "</div>" +
      actionHtml +
      "</div>";

    var cancelBtn = card.querySelector('[data-action="cancel"]');
    if (cancelBtn) {
      cancelBtn.addEventListener("click", function () {
        DHYAN.updateRequest(req.id, { status: "cancelled" });
        DHYAN_UI.toast("Request cancelled.");
        renderAll();
      });
    }

    return card;
  }

  function renderAll() {
    var requests = DHYAN.getRequests();
    var received = requests.filter(function (r) {
      return r.direction === "received";
    });
    var sent = requests.filter(function (r) {
      return r.direction === "sent";
    });

    receivedPanel.innerHTML = "";
    if (received.length === 0) {
      var e1 = document.createElement("div");
      e1.className = "dhyan-empty-state";
      e1.textContent = "No received requests yet.";
      receivedPanel.appendChild(e1);
    } else {
      received.forEach(function (r) {
        receivedPanel.appendChild(renderReceivedCard(r));
      });
    }

    sentPanel.innerHTML = "";
    if (sent.length === 0) {
      var e2 = document.createElement("div");
      e2.className = "dhyan-empty-state";
      e2.textContent = "You haven't sent any requests yet.";
      sentPanel.appendChild(e2);
    } else {
      sent.forEach(function (r) {
        sentPanel.appendChild(renderSentCard(r));
      });
    }
  }

  renderAll();
});
