$(document).ready(function() {
  var socket = new WebSocket("wss://echo.websocket.org?id=4");

  socket.onmessage = function(event) {
    chatMessage = JSON.parse(event.data);

    $(".chat-message-container").append(chatMessageDiv(chatMessage, 'left'));
  };

  $(".chat-message-submit").on("click", function(e) {
    e.preventDefault();

    var params = $(this).parent("form").serializeArray();
    var data = $(this).parent("form").serialize();
    var url = $(this).parent("form").attr("action");

    var request = $.ajax({
      type: "POST",
      dataType: "json",
      url,
      data
    }).done(function(chatMessage) {
      stringifiedChatMessage = JSON.stringify(chatMessage);

      $(".chat-message-container").append(chatMessageDiv(chatMessage, 'right'));

      socket.send(stringifiedChatMessage);
    }).error(function() {
      console.log("Bummer...");
    });
  });

  var chatMessageDiv = function(chatMessage, messageClass) {
    var message = $('<p/>').text(chatMessage.message);
    var timestamp = $('<p/>').addClass('small').text(chatMessage.created_at);

    return $('<div/>').addClass('chat-message ' + messageClass).append(message, timestamp);
  }
});
