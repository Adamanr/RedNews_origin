class AddVerifiedToEditions < ActiveRecord::Migration[7.0]
  def change
    add_column :editions, :verified, :boolean
  end
end
