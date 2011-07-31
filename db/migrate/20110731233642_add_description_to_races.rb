class AddDescriptionToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :description, :text
  end

  def self.down
    remove_column :races, :description
  end
end
