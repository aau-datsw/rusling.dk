class CreateMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :link
      t.string :name
      t.string :image_url
      t.string :description
      t.references :menu

      t.timestamps
    end
  end
end
