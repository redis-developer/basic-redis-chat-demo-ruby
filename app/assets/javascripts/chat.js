$('document').ready(function functionName() {
  let messages_count = $('#room-messages-count').last().attr('data-messages-count')
  if (messages_count > 1) {
    $('.main-chat-box').scrollTop($('.message-block').last().offset().top)
  }
})
