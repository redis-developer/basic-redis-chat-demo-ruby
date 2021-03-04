class RemoveOnlineToUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :online, default: false
  end
end
