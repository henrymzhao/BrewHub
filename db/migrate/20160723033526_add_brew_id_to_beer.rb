class AddBrewIdToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :beer_brewery_id, :integer
  end
end
