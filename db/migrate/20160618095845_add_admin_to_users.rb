class AddAdminToUsers < ActiveRecord::Migration
  def change
<<<<<<< HEAD
<<<<<<< HEAD
    add_column :users, :admin, :boolean, null: false, default: false
=======
    add_column :users, :Admin, :boolean, null: false, default: false
>>>>>>> refs/remotes/origin/master
=======
    add_column :users, :admin, :boolean, null: false, default: false
>>>>>>> refs/remotes/origin/master
  end
end
