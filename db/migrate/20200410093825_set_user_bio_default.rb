class SetUserBioDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default(:users, :bio, "")
  end
end
