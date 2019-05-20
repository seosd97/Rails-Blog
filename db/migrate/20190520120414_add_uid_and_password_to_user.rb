class AddUidAndPasswordToUser < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :name, :uid
    add_column :users, :password, :string, null: false, default: '1234'
  end
end
