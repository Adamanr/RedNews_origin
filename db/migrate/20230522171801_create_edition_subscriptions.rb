class CreateEditionSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :edition_subscriptions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :edition, null: false, foreign_key: true

      t.timestamps
    end
  end
end
