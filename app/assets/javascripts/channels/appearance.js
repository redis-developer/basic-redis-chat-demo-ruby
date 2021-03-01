App.appearance = App.cable.subscriptions.create("AppearanceChannel", {
  received: function(data) {
    let parentDiv = $(`[data-user-id=${data.user_id}]`)
    parentDiv.removeClass('bg-gray').addClass('bg-success');
  }
});
