class AddIdToBrewery < ActiveRecord::Migration
  def change
    add_column :breweries, :brew_id, :integer
  end
end
