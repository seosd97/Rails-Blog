class Changeusernametopostandcomment < ActiveRecord::Migration[5.2]
  def change
    rename_column :posts, :user_name, :owner
    rename_column :comments, :user_name, :owner
  end
end
