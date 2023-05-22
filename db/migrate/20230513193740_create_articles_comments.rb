class CreateArticlesComments < ActiveRecord::Migration[7.0]
  def change
    create_table :articles_comments do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true

      t.timestamps
    end
  end
end
