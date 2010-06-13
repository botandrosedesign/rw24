class RemovePhoneFromTeams < ActiveRecord::Migration
  def self.up
    remove_column :teams, :phone
  end

  def self.down
    add_column :teams, :phone, :string
  end
end
