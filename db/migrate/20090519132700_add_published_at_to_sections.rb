class AddPublishedAtToSections < ActiveRecord::Migration[4.2]
  def self.up
    add_column :sections, :published_at, :datetime
  end

  def self.down
    remove_column :sections, :published_at
  end
end
