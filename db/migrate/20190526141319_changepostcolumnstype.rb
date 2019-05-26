class Changepostcolumnstype < ActiveRecord::Migration[5.2]
  def change
    change_column :posts, :title, :text
    change_column :posts, :description, :text
  end
end
