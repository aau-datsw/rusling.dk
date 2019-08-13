class FixColorDefaultValue < ActiveRecord::Migration[5.2]
  def up
    change_column_default :educational_domains, :colors, []
  end

  def down
    change_column_default :educational_domains, :colors, nil
  end
end
