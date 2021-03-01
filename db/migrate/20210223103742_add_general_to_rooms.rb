class AddGeneralToRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :rooms, :general, :boolean, default: false
  end
end
