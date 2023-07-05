class AddCompoundUniquenessIndexForTeamsPositionAndRaceId < ActiveRecord::Migration[7.0]
  def change
    add_index :teams, [:position, :race_id], unique: true
  end
end
