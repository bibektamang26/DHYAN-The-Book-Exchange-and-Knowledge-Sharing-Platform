/* Applies the saved appearance (light/dark/system) as early as possible
   so every page — including login/register — respects it with no flash. */
(function () {
  function applyTheme(mode) {
    var resolved = mode;
    if (mode === "system") {
      var prefersDark =
        window.matchMedia &&
        window.matchMedia("(prefers-color-scheme: dark)").matches;
      resolved = prefersDark ? "dark" : "light";
    }
    document.documentElement.setAttribute("data-theme", resolved);
    document.documentElement.setAttribute("data-theme-choice", mode);
  }

  var saved = localStorage.getItem("dhyan-theme") || "light";
  applyTheme(saved);

  window.DHYAN_applyTheme = applyTheme;
})();
