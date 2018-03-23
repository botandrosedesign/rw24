class AddPositionToTeams < ActiveRecord::Migration[4.2]
  def self.up
    add_column :teams, :position, :integer
  end

  def self.down
    remove_column :teams, :position
  end
end
