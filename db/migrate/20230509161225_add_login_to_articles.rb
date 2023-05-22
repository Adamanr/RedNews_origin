class AddLoginToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :login, :string
  end
end
