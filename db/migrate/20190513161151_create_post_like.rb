class CreatePostLike < ActiveRecord::Migration[5.2]
  def change
    create_table :post_likes do |t|
      t.belongs_to :post, null: false, index: true
    end
  end
end
