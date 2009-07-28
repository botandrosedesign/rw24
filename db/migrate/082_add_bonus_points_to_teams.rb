class AddBonusPointsToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :bonus_points, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :teams, :bonus_points
  end
end
