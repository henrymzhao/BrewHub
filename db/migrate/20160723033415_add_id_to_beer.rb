class AddIdToBeer < ActiveRecord::Migration
  def change
    add_column :beers, :beer_id, :integer
  end
end
