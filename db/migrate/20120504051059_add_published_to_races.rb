class AddPublishedToRaces < ActiveRecord::Migration[4.2]
  def self.up
    add_column :races, :published, :boolean
  end

  def self.down
    remove_column :races, :published
  end
end
