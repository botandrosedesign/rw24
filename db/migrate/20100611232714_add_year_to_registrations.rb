class AddYearToRegistrations < ActiveRecord::Migration[4.2]
  def self.up
    add_column :registrations, :year, :integer
  end

  def self.down
    remove_column :registrations, :year
  end
end
