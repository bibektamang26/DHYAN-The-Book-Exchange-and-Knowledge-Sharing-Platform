/* Shared tiny UI helpers: toast notifications + a generic modal
   builder, so every page can surface feedback without changing
   the visual language of the app. */
(function (global) {
  "use strict";

  function toastContainer() {
    var el = document.getElementById("dhyan-toast-container");
    if (!el) {
      el = document.createElement("div");
      el.id = "dhyan-toast-container";
      document.body.appendChild(el);
    }
    return el;
  }

  function toast(message, type) {
    var container = toastContainer();
    var el = document.createElement("div");
    el.className = "dhyan-toast" + (type ? " " + type : "");
    el.textContent = message;
    container.appendChild(el);
    setTimeout(function () {
      el.style.transition = "opacity 0.3s ease";
      el.style.opacity = "0";
      setTimeout(function () {
        el.remove();
      }, 300);
    }, 2600);
  }

  // Builds and shows a modal. `config`:
  //   title: string
  //   fields: [{ name, label, type ('text'|'select'|'textarea'), options, value, placeholder }]
  //   confirmLabel, cancelLabel
  //   onConfirm(values) -> return false (or a string error) to keep modal open
  function openModal(config) {
    var overlay = document.createElement("div");
    overlay.className = "dhyan-modal-overlay";

    var modal = document.createElement("div");
    modal.className = "dhyan-modal";

    var header = document.createElement("div");
    header.className = "dhyan-modal-header";
    header.innerHTML =
      "<h3></h3><button type=\"button\" class=\"dhyan-modal-close\" aria-label=\"Close\"><i class=\"fa-solid fa-xmark\"></i></button>";
    header.querySelector("h3").textContent = config.title || "";
    modal.appendChild(header);

    var body = document.createElement("div");
    body.className = "dhyan-modal-body";

    var errorText = document.createElement("div");
    errorText.className = "dhyan-error-text";

    var inputs = {};
    (config.fields || []).forEach(function (field) {
      var wrap = document.createElement("div");
      wrap.className = "dhyan-field";

      var label = document.createElement("label");
      label.textContent = field.label;
      label.setAttribute("for", "dhyan-field-" + field.name);
      wrap.appendChild(label);

      var input;
      if (field.type === "select") {
        input = document.createElement("select");
        (field.options || []).forEach(function (opt) {
          var o = document.createElement("option");
          o.value = opt.value;
          o.textContent = opt.label;
          input.appendChild(o);
        });
      } else if (field.type === "textarea") {
        input = document.createElement("textarea");
        input.rows = field.rows || 3;
      } else {
        input = document.createElement("input");
        input.type = field.type || "text";
      }
      input.id = "dhyan-field-" + field.name;
      if (field.placeholder) input.placeholder = field.placeholder;
      if (field.value !== undefined) input.value = field.value;
      wrap.appendChild(input);

      body.appendChild(wrap);
      inputs[field.name] = input;
    });

    body.appendChild(errorText);
    modal.appendChild(body);

    var footer = document.createElement("div");
    footer.className = "dhyan-modal-footer";

    var cancelBtn = document.createElement("button");
    cancelBtn.type = "button";
    cancelBtn.className = "dhyan-btn dhyan-btn-secondary";
    cancelBtn.textContent = config.cancelLabel || "Cancel";

    var confirmBtn = document.createElement("button");
    confirmBtn.type = "button";
    confirmBtn.className = "dhyan-btn dhyan-btn-primary";
    confirmBtn.textContent = config.confirmLabel || "Save";

    footer.appendChild(cancelBtn);
    footer.appendChild(confirmBtn);
    modal.appendChild(footer);

    overlay.appendChild(modal);
    document.body.appendChild(overlay);

    function close() {
      overlay.remove();
    }

    header.querySelector(".dhyan-modal-close").addEventListener("click", close);
    cancelBtn.addEventListener("click", close);
    overlay.addEventListener("click", function (e) {
      if (e.target === overlay) close();
    });

    confirmBtn.addEventListener("click", function () {
      var values = {};
      Object.keys(inputs).forEach(function (name) {
        values[name] = inputs[name].value;
      });
      var result = config.onConfirm ? config.onConfirm(values) : true;
      if (result === false) {
        errorText.textContent = "Please fill in all required fields.";
        return;
      }
      if (typeof result === "string") {
        errorText.textContent = result;
        return;
      }
      close();
    });

    var firstInput = body.querySelector("input, select, textarea");
    if (firstInput) firstInput.focus();

    return { close: close };
  }

  function confirmDialog(message) {
    return window.confirm(message);
  }

  global.DHYAN_UI = {
    toast: toast,
    openModal: openModal,
    confirm: confirmDialog,
  };
})(window);
