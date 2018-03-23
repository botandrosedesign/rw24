class AddCityStateZipToTeams < ActiveRecord::Migration[4.2]
  def self.up
    add_column :teams, :city, :string
    add_column :teams, :state, :string
    add_column :teams, :zip, :string
  end

  def self.down
    remove_column :teams, :zip
    remove_column :teams, :state
    remove_column :teams, :city
  end
end
