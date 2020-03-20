class RemoveWrongColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :owner
    remove_column :comments, :owner
    change_column :users, :role, :string, null: false
    change_column_default(:users, :role, nil)
  end
end
