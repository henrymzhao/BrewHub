class AddProvinceToBeers < ActiveRecord::Migration
  def change
    add_column :beers, :loc, :string
  end
end
