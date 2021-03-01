class AddedUsernameToRoomMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :room_messages, :username, :string
  end
end
