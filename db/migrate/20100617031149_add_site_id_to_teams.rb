class AddSiteIdToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :site_id, :integer
  end

  def self.down
    remove_column :teams, :site_id
  end
end
