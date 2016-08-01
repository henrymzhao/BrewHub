class ChangeLatAndLonToFloat < ActiveRecord::Migration
  def change
    change_column :breweries, :latitude, :float
    change_column :breweries, :longitude, :float
  end
end
