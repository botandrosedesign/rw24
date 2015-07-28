class AddNestingToArticles < ActiveRecord::Migration
  def self.up
    remove_column :contents, :position
    add_column :contents, :parent_id, :integer
    add_column :contents, :lft, :integer, :default => 0, :null => false
    add_column :contents, :rgt, :integer, :default => 0, :null => false
  end

  def self.down
    add_column  :contents, :position, :integer
    remove_column :contents, :parent_id
    remove_column :contents, :lft
    remove_column :contents, :rgt
  end
end
