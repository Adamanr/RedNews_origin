class CreateEditions < ActiveRecord::Migration[7.0]
  def change
    create_table :editions do |t|
      t.string :name
      t.string :desc
      t.string :url
      t.references :user, null: false, foreign_key: true
      t.string :category
      t.float :rating
      t.boolean :verified

      t.timestamps
    end
  end
end
