class AddLatlngToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :latitude, :string
    add_column :breweries, :longitude, :string
  end
end
