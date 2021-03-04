App.appearance = App.cable.subscriptions.create("AppearanceChannel", {
  connected() {},

  disconnected() {},

  received: function(data) {
    let parentDiv = $(`[data-user-id=${data.user_id}]`)
    if (data.online === true) {
      parentDiv.removeClass('bg-gray').addClass('bg-success');
    } else {
      parentDiv.removeClass('bg-success').addClass('bg-gray');
    }
  }
});
