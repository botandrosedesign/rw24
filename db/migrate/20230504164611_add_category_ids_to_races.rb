class AddCategoryIdsToRaces < ActiveRecord::Migration[7.0]
  def change
    add_column :races, :category_ids, :string
  end
end
