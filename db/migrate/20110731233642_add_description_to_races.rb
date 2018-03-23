class AddDescriptionToRaces < ActiveRecord::Migration[4.2]
  def self.up
    add_column :races, :description, :text
  end

  def self.down
    remove_column :races, :description
  end
end
