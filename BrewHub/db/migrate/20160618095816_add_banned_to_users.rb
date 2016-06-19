class AddBannedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :Banned, :boolean, default: false
  end
end
