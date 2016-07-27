class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.decimal :lat
      t.decimal :lon
      t.integer :group_id

      t.timestamps null: false
    end
  end
end
