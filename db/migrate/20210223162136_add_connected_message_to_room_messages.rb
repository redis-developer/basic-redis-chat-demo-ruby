class AddConnectedMessageToRoomMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :room_messages, :connected_message, :boolean, default: false
  end
end
