class AddOrderToAccordionItems < ActiveRecord::Migration[5.2]
  def change
    add_column :accordion_items, :position, :integer
    add_index :accordion_items, :position
    add_column :menu_items, :position, :integer
    add_index :menu_items, :position
  end
end
