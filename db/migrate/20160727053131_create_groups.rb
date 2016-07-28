class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :brewery_id
      t.integer :leader

      t.timestamps null: false
    end
  end
end
