class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :website
      t.string :address
      t.string :gpsLocation
      t.string :latitude
      t.string :longitude
      t.string :brewery_id
      t.string :imgUrl
      t.text   :description
      t.string :locality
      t.string :province

      t.timestamps null: false
    end
  end
end
