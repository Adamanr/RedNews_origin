class AddImpressionsCountToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :impressions_count, :integer
  end
end
