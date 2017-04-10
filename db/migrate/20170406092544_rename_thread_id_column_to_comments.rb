class RenameThreadIdColumnToComments < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :thread_id, :room_id
  end
end
