class AddSiteIdToTeams < ActiveRecord::Migration[4.2]
  def self.up
    add_column :teams, :site_id, :integer
  end

  def self.down
    remove_column :teams, :site_id
  end
end
