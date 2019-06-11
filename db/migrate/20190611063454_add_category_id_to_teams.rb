class AddCategoryIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :category_id, :integer
  end
end
