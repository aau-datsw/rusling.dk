class AddColorsToMenuItems < ActiveRecord::Migration[5.2]
  def change
    add_column :menu_items, :colors, :jsonb
  end
end
