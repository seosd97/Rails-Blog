class AddVisitorCountToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :visitor_count, :integer, null: false, default: 0
  end
end
