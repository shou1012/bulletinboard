class ChangeColumnNullToRooms < ActiveRecord::Migration[5.0]
  def down
    change_column :rooms, :name, :string, null: true, default: nil
    change_column :rooms, :user_id, :integer, null: true, default: nil
  end

  def up
    change_column :rooms, :name, :string, null: false
    change_column :rooms, :user_id, :integer, null: false
  end
end
