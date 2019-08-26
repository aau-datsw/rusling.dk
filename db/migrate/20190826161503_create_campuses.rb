class CreateCampuses < ActiveRecord::Migration[5.2]
  def change
    create_table :campuses do |t|
      t.string :name
      t.string :university

      t.timestamps
    end
    add_index :campuses, :name
    add_index :campuses, :university
    add_reference :educational_domains, :campus, index: true, foreign_key: true
  end
end
