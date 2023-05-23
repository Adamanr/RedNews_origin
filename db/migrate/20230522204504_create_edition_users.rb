class CreateEditionUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :edition_users do |t|
      t.references :edition, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :role_id

      t.timestamps
    end
  end
end
