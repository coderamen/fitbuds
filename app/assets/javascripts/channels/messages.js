$(document).ready(function() {

  // scroll to botom on load
  $('.chat').scrollTop($('.chat').prop('scrollHeight'));

  App.messages = App.cable.subscriptions.create({channel: 'MessagesChannel', match_id: $('.chatbox').data('match-id')}, {
    received: function(data) {
      var $newMessage = $('<li></li>');

      if (data.user_id === $('.chatbox').data('self')) {
        $newMessage.addClass('self');
      }
      else if (data.user_id === $('.chatbox').data('other')) {
        $newMessage.addClass('other');
      }
      $newMessage.append('<div></div>');
      $newMessage.children().addClass('msg');

      $newMessage.children().html('<p>' + data.message + '</p>');
      $('ol.chat').append($newMessage);

      // scroll to bottom of chat panel with animation
      $('.chat').animate({
        scrollTop: $('.chat').prop('scrollHeight')
      }, 500);
    }
  });



  $(document).on('turbolinks:load', function() {
    $('.reply-msg > form').submit(function() {
      var msg = $(this).children('#message_content').val();
      var matchId = $('.chatbox').data('match-id');
      var userId = $('.chatbox').data('self');

      App.messages.send({content: msg, match_id: matchId, user_id: userId});
      $(this).children('#message_content').val('');

      return false;
    });
  });
});