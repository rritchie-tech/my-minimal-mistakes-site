window.addEventListener('scroll', () => {
  const element = document.getElementById('dropdown-Home');
  if (window.scrollY > 200) { // Example: after scrolling 200px
	if (window.scrollY < 400)
	{
		element.style.opacity =  ((window.scrollY/2)-100)/200;
		
	} else {
	element.style.opacity = 1;
	}
  } else {
    element.style.opacity = 0;
  }
});