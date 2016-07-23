class CreateBeers < ActiveRecord::Migration
  def change
    create_table :beers do |t|
      t.string :name
      t.integer :ibu
      t.integer :abv
      t.integer :styleId
      t.integer :srmId
      t.string :beer_brewery_id
      t.string :beer_id
      t.timestamps null: false
    end
  end
end
