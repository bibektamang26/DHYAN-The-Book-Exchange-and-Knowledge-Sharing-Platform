
// Loading Sidebar
var sidebarEl = document.getElementById("sidebar");
if (sidebarEl) {
  fetch("components/sidebar.jsp")
    .then((response) => response.text())
    .then((data) => {
      sidebarEl.innerHTML = data;
      highlightActiveNavItem(); 
    });
}

// Highlight the active sidebar link
function highlightActiveNavItem() {
    const currentPage = window.location.pathname.split("/").pop();

    document.querySelectorAll(".sidebar .nav-item").forEach((link) => {
        const linkPage = link.getAttribute("href").split("/").pop();

        if (linkPage === currentPage) {
            link.classList.add("active");
        }
    });
}

var navBell = document.querySelector(".navbar .notifications");
if (navBell && !navBell.dataset.wired) {
    navBell.dataset.wired = "true";

    var modalHtml = 
        '<div id="dhyan-notice-modal" style="display:none; position:fixed; z-index:9999; left:72%; top:2%; width:100%; height:55%; overflow:hidden; alignItems:center; justifyContent:center; border-radius:12px;">' +
            '<div style="background:rgb(240, 260, 280);; padding:16px; border-radius:8px; width:280px; position:relative; textAlign:center; box-shadow:0 10px 30px -5px rgba(15,23,42,0.25), 0 4px 12px -2px rgba(15,23,42,0.15);; fontFamily:sans-serif;">' +
                '<span id="close-notice-modal" style="position:absolute; right:12px; top:4px;fontSize:24px; cursor:pointer; color: black; fontWeight:bold; ">&times;</span>' +
                '<img src="assets/images/profile.jpeg" alt="CEO" style="width:80px; height:80px; borderRadius:50%; objectFit:contain; margin:8px auto; border:3px solid #f4f6f9;" onerror="this.src=\'https://placehold.co\'" />' +
                '<h3 style="margin:4px 0; color:#222; fontSize:15px; fontWeight:bold;">Meet the CEO!</h3>' +
                '<p style="color:#666; fontSize:12px; margin:4px 0 10px 0; lineHeight:1.4;">' +
                    'Chat live with <strong>Mr. Bibek Tamang</strong>, Co-founder of <strong>DHYAN Group of Technologies!</strong>' +
                '</p>' +
                '<div style="background:#f4f6f9; color:#444; fontSize:11px; padding:6px; borderRadius:8px; fontWeight:6px;margin-bottom:8px;">' +
                    '📅 Oct 15, 2026' +
                '</div>' +
                '<div style="background:#f4f6f9; color:#444; fontSize:11px; padding:6px; borderRadius:6px; fontWeight:6px;">' +
                    '📍 <strong>Venue:</strong> Main Conference Hall, 4th Floor, DHYAN HQ, Kathmandu' +
                '</div>' +
            '</div>' +
        '</div>';

    document.body.insertAdjacentHTML('beforeend', modalHtml);

    var modal = document.getElementById("dhyan-notice-modal");
    var closeBtn = document.getElementById("close-notice-modal");

    navBell.addEventListener("click", function(e) {
        e.preventDefault();
        modal.style.display = "flex";
    });

    closeBtn.addEventListener("click", function() {
        modal.style.display = "none";
    });

    window.addEventListener("click", function(event) {
        if (event.target === modal) {
            modal.style.display = "none";
        }
    });
}

