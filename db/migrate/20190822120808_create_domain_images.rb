class CreateDomainImages < ActiveRecord::Migration[5.2]
  def change
    create_table :domain_images do |t|
      t.string :name
      t.references :educational_domain, foreign_key: true

      t.timestamps
    end
  end
end
