class RemoveLegacyCategoryField < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :legacy_category, :string
  end
end
