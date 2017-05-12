$(document).ready(function() {
  $('#back-to-top-link').click(function(e) {
    e.preventDefault();
    $('html').animate({ scrollTop: 0 }, 'slow');
  });

  $('#about-us-link').click(function(e) {
    e.preventDefault();
    var bottom = $('html').prop('scrollHeight');
    $('html').animate({ scrollTop: bottom }, 'slow');
  });

  $('#back-to-nav').click(function(e) {
    e.preventDefault();
    var signUpDiv = $('#howto-signinup-bg').offset().top;
    $('html').animate({ scrollTop: signUpDiv }, 'slow');
  });
});