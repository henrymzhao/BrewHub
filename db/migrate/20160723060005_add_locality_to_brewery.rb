class AddLocalityToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :locality, :string
    add_column :breweries, :description, :text
    add_column :breweries, :imgUrl, :string
  end
end
