class AddUserIdtoComment < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :user, foreign_key: { on_delete: :cascade }
  end
end
