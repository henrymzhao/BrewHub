class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.integer :style_id
      t.decimal :ibuMin
      t.decimal :ibuMax
      t.decimal :abvMin
      t.decimal :abvMax
      t.decimal :srmMin
      t.decimal :srmMax

      t.timestamps null: false
    end
  end
end
