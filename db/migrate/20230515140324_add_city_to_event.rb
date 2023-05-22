class AddCityToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :city, :string
  end
end
