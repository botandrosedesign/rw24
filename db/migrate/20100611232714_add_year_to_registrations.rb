class AddYearToRegistrations < ActiveRecord::Migration
  def self.up
    add_column :registrations, :year, :integer
  end

  def self.down
    remove_column :registrations, :year
  end
end
