document.addEventListener("DOMContentLoaded", function() {
  const artist_signUpButton = document.getElementById('artist_signUp');
  const artist_signInButton = document.getElementById('artist_signIn');
  const artist_container = document.getElementById('artist_registration');

  artist_signUpButton.addEventListener('click', () => {
    artist_container.classList.add("right-panel-active");
  });

  artist_signInButton.addEventListener('click', () => {
    artist_container.classList.remove("right-panel-active");
  });
}, false);