class AddProvinceToBreweries < ActiveRecord::Migration
  def change
    add_column :breweries, :loc, :string
  end
end
