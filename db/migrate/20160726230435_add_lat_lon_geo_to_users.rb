class AddLatLonGeoToUsers < ActiveRecord::Migration
  def change
    #http://stackoverflow.com/questions/1196174/correct-datatype-for-latitude-and-longitude-in-activerecord
    add_column :users, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :users, :lon, :decimal, {:precision=>10, :scale=>6}
  end
end
