class AddEndAtToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :end_at, :datetime
  end
end
