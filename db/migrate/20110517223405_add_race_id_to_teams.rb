class AddRaceIdToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :race_id, :integer
  end

  def self.down
    remove_column :teams, :race_id
  end
end
