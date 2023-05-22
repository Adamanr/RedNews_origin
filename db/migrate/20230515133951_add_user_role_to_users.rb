class AddUserRoleToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :user_role, null: false, foreign_key: true
  end
end
