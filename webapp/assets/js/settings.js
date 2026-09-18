document.addEventListener("DOMContentLoaded", function () {
  var settingsPage = document.querySelector(".settings");
  if (!settingsPage) return;
	
  //  Appearance
  var appearanceCards = document.querySelectorAll(".appearance-card");
  var savedTheme = localStorage.getItem("dhyan-theme") || "light";

  function markActiveCard(mode) {
    appearanceCards.forEach(function (card) {
      card.classList.toggle(
        "appearance-card-active",
        card.dataset.mode === mode
      );
    });
  }
  markActiveCard(savedTheme);

  appearanceCards.forEach(function (card) {
    card.addEventListener("click", function () {
      var mode = card.dataset.mode;
      localStorage.setItem("dhyan-theme", mode);
      if (window.DHYAN_applyTheme) window.DHYAN_applyTheme(mode);
      markActiveCard(mode);
      DHYAN_UI.toast(
        "Appearance set to " + card.querySelector("h4").textContent + "."
      );
    });
  });

  //Profile fields (Edit details / Save / Cancel)
  var editBtn = document.getElementById("edit-profile-btn");
  var displayNameInput = document.getElementById("display-name");
  var academicBioInput = document.getElementById("academic-bio");
  var saveBtn = document.querySelector(".btn-save");
  var cancelBtn = document.querySelector(".btn-cancel");

  function loadProfileFields() {
    var profile = DHYAN.getProfile();
    if (displayNameInput)
      displayNameInput.value = profile.displayName || profile.name || "";
    if (academicBioInput) academicBioInput.value = profile.academicBio || "";
  }
  loadProfileFields();

  function setFieldsEditable(editable) {
    if (displayNameInput) displayNameInput.readOnly = !editable;
    if (academicBioInput) academicBioInput.readOnly = !editable;
    if (editable && displayNameInput) displayNameInput.focus();
  }

  if (editBtn) {
    editBtn.addEventListener("click", function (e) {
      e.preventDefault();
      setFieldsEditable(true);
      DHYAN_UI.toast("You can now edit your profile fields below.");
    });
  }

  if (saveBtn) {
    saveBtn.addEventListener("click", function () {
      DHYAN.updateProfile({
        displayName: displayNameInput.value.trim(),
        name: displayNameInput.value.trim(),
        academicBio: academicBioInput.value.trim(),
      });
      setFieldsEditable(false);
      DHYAN_UI.toast("Changes saved.", "success");
    });
  }

  if (cancelBtn) {
    cancelBtn.addEventListener("click", function () {
      loadProfileFields();
      setFieldsEditable(false);
      DHYAN_UI.toast("Changes discarded.");
    });
  }

  //  Notification toggles -
  var settings = DHYAN.getSettings();
  document.querySelectorAll(".toggle[data-setting]").forEach(function (toggle) {
    var key = toggle.dataset.setting;
    var isOn = !!settings.notifications[key];
    toggle.classList.toggle("toggle-on", isOn);
    toggle.setAttribute("aria-pressed", isOn ? "true" : "false");

    toggle.addEventListener("click", function () {
      var nowOn = !toggle.classList.contains("toggle-on");
      toggle.classList.toggle("toggle-on", nowOn);
      toggle.setAttribute("aria-pressed", nowOn ? "true" : "false");
      var current = DHYAN.getSettings();
      current.notifications[key] = nowOn;
      DHYAN.updateSettings({ notifications: current.notifications });
    });
  });

  //  Security
  var changePasswordLink = document.getElementById("change-password-link");
  if (changePasswordLink) {
    changePasswordLink.addEventListener("click", function (e) {
      e.preventDefault();
      DHYAN_UI.openModal({
        title: "Change Password",
        confirmLabel: "Update Password",
        fields: [
          { name: "current", label: "Current Password", type: "password" },
          { name: "next", label: "New Password", type: "password" },
          { name: "confirm", label: "Confirm New Password", type: "password" },
        ],
        onConfirm: function (values) {
          var current = DHYAN.getSettings();
          if (values.current !== current.password) {
            return "Current password is incorrect.";
          }
          if (!values.next || values.next.length < 8) {
            return "New password must be at least 8 characters.";
          }
          if (values.next !== values.confirm) {
            return "New passwords do not match.";
          }
          DHYAN.updateSettings({ password: values.next });
          DHYAN_UI.toast("Password updated.", "success");
        },
      });
    });
  }

  var twoFactorLink = document.getElementById("two-factor-link");
  var twoFactorStatus = document.getElementById("two-factor-status");
  function renderTwoFactor() {
    var s = DHYAN.getSettings();
    if (twoFactorStatus) {
      twoFactorStatus.textContent = s.twoFactor ? "(Enabled)" : "(Disabled)";
    }
  }
  renderTwoFactor();

  if (twoFactorLink) {
    twoFactorLink.addEventListener("click", function (e) {
      e.preventDefault();
      var s = DHYAN.getSettings();
      var next = !s.twoFactor;
      DHYAN.updateSettings({ twoFactor: next });
      renderTwoFactor();
      DHYAN_UI.toast(
        next
          ? "Two-factor authentication enabled."
          : "Two-factor authentication disabled.",
        "success"
      );
    });
  }

  var deactivateLink = document.getElementById("deactivate-link");
  if (deactivateLink) {
    deactivateLink.addEventListener("click", function (e) {
      e.preventDefault();
      var confirmed = DHYAN_UI.confirm(
        "Deactivating will sign you out. You can sign back in any time with the same email and password. Continue?"
      );
      if (!confirmed) return;
      DHYAN.logout();
      window.location.href = "login.html";
    });
  }
});
