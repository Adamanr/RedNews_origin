class AddEditionToEvent < ActiveRecord::Migration[7.0]
  def change
    add_reference :events, :edition, null: false, foreign_key: true
  end
end
