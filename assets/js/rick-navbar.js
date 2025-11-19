/* --- Navbar --- */	
	let myDiv = document.getElementById("nav-container");
	var navScroll = window.scrollY
	$(window).scroll(function() {
        if (window.scrollY > 50) {
            myDiv.className = "sticky";
        } else {
            myDiv.className = "";
        }
    });