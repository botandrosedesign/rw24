class RemoveTeamsSiteId < ActiveRecord::Migration[7.1]
  def change
    remove_column :teams, :site_id, :integer, index: true
  end
end
