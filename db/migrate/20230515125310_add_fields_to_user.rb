class AddFieldsToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :city, :string
    add_column :users, :verified, :boolean
  end
end
