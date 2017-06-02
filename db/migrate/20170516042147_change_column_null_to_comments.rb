class ChangeColumnNullToComments < ActiveRecord::Migration[5.0]
  def down
    change_column :comments, :text, :string, null: true, default: nil
  end

  def up
    change_column :comments, :text, :string, null: false
  end
end
