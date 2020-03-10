class RemoveDefaultPassword < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :password_digest, nil)
  end
end
