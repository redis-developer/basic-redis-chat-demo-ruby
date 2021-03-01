$(function() {
  $('[data-channel-subscribe="room"]').each(function(index, element) {
    let $element = $(element),
        room_id = $element.data('room-id')
        messageTemplate = $('[data-role="message-template"]');

    App.cable.subscriptions.create(
      {
        channel: "RoomChannel",
        room: room_id
      },
      {
        received: function(data) {
          let updatedDate = new Date(data.updated_at);
          let updateTime = updatedDate.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true }).toLowerCase()
          var content = messageTemplate.children().clone(true, true);
          content.find('[data-role="message-text"]').text(data.message);
          content.find('[data-role="message-date"]').text(updateTime);
          content.find('[data-role="message-user-id"]').text(data.user_id);
          content.find('[data-role="message-username"]').text(data.username);
          if (room_id === data.room_id) {
            $element.append(content);
          }
          $(`.chat-list-last-message-${data.room_id}`).each(function () {
            $(this).html(data.message);
          });
          let messagesCount = $('#room-messages-count').last().attr('data-messages-count')
          if (messagesCount > 1) {
            $('.main-chat-box').scrollTop(30000)
          }

          let emptyDiv = $('.chat .empty-message-div').last()
          let roomsShowMessage = $('.chat .rooms-show-message-position').last()
          let roundedCircleSocket = $('.chat .rounded-circle-socket').last()

          if (parseInt(emptyDiv.attr('data-message-user-id')) === data.user_id) {
            roomsShowMessage.addClass('text-right')
            emptyDiv.removeClass('hide')
            roundedCircleSocket.removeClass('bg-success')
          } else {
            roomsShowMessage.removeClass('text-right')
            roundedCircleSocket.addClass('bg-success')
            emptyDiv.addClass('hide')
          }

          let chatMessageSocket = $('.chat .message-socket').last()
          let chatConnetedMessageSocket = $('.chat .connected-message-socket').last()
          if (data.connected_message === true) {
            chatMessageSocket.removeClass('d-flex').addClass('hide');
            chatConnetedMessageSocket.removeClass('hide');
          } else {
            chatMessageSocket.removeClass('hide').addClass('d-flex');
            chatConnetedMessageSocket.addClass('hide');
          }
        }
      }
    );
  });
});
