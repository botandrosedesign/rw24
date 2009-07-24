class AddCheckedInToRacers < ActiveRecord::Migration
  def self.up
    add_column :racers, :checked_in, :boolean
  end

  def self.down
    remove_column :racers, :checked_in
  end
end
