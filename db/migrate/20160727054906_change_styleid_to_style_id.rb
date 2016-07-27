class ChangeStyleidToStyleId < ActiveRecord::Migration
  def change
    rename_column :beers, :styleId, :style_id
  end
end
