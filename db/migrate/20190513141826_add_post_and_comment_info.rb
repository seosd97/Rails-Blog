class AddPostAndCommentInfo < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :posts, null: true
    add_timestamps :comments, null: true
    add_column :posts, :user_name, :string
    add_column :comments, :user_name, :string 
  end
end
