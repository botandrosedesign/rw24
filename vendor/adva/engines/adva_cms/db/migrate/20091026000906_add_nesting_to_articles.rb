class AddNestingToArticles < ActiveRecord::Migration
  def self.up
    remove_column :contents, :position
    add_column :contents, :parent_id, :integer
    add_column :contents, :lft, :integer, :default => 0, :null => false
    add_column :contents, :rgt, :integer, :default => 0, :null => false

    # initialize lft, rgt, and parent_ids in all articles for each section
    Article.all.group_by(&:section).each do |section, articles| 
      articles.each_with_index do |a, i|
        a.parent_id = nil
        a.lft = i*2+1
        a.rgt = i*2+2
        a.save
      end
    end

  end

  def self.down
    add_column  :contents, :position, :integer
    remove_column :contents, :parent_id
    remove_column :contents, :lft
    remove_column :contents, :rgt
  end
end
