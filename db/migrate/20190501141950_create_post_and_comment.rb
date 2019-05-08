class CreatePostAndComment < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
    end

    create_table :comments do |t|
      t.string :description
      t.belongs_to :post, null: false, index: true
    end
  end
end
