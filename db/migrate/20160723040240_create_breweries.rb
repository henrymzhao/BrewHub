class CreateBreweries < ActiveRecord::Migration
  def change
    create_table :breweries do |t|
      t.string :name
      t.string :website
      t.string :address
      t.string :gpsLocation
      t.string :latitude
      t.string :longitude
      t.string :brew_id
      t.string :imgUrl
      t.text   :description
      t.string :locality

      t.timestamps null: false
    end
  end
end
