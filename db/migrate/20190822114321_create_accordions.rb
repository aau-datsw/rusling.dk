class CreateAccordions < ActiveRecord::Migration[5.2]
  def change
    create_table :accordion_items do |t|
      t.string :title
      t.string :content
      t.references :page

      t.timestamps
    end
  end
end
