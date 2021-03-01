App.disappearance = App.cable.subscriptions.create("DisappearanceChannel", {
  received: function(data) {
    let parentDiv = $(`[data-user-id=${data.user_id}]`)
    parentDiv.removeClass('bg-success').addClass('bg-gray');
  }
});
