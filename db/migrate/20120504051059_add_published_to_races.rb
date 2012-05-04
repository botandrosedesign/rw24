class AddPublishedToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :published, :boolean
  end

  def self.down
    remove_column :races, :published
  end
end
