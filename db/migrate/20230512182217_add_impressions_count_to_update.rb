class AddImpressionsCountToUpdate < ActiveRecord::Migration[7.0]
  def change
    add_column :updates, :impressions_count, :integer
  end
end
