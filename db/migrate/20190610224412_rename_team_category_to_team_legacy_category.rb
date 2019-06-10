class RenameTeamCategoryToTeamLegacyCategory < ActiveRecord::Migration[5.2]
  def change
    rename_column :teams, :category, :legacy_category
  end
end
