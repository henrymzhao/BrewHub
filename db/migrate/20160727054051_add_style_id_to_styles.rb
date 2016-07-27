class AddStyleIdToStyles < ActiveRecord::Migration
  def change
        add_column :styles, :style_id, :integer
  end
end
