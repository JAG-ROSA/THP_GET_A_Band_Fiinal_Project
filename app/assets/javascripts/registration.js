document.addEventListener("DOMContentLoaded", function() {
  if(
    document.getElementById('signUp') != undefined &&
    document.getElementById('signIn') != undefined &&
    document.getElementById('registration') != undefined){

    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const container = document.getElementById('registration');

    signUpButton.addEventListener('click', () => {
      container.classList.add("right-panel-active");
    });

    signInButton.addEventListener('click', () => {
      container.classList.remove("right-panel-active");
    });
  }
}, false);
