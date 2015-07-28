class AddPublishedAtToSections < ActiveRecord::Migration
  def self.up
    add_column :sections, :published_at, :datetime
  end

  def self.down
    remove_column :sections, :published_at
  end
end
