class AddStartTimeToRaces < ActiveRecord::Migration
  def self.up
    add_column :races, :start_time, :datetime
  end

  def self.down
    remove_column :races, :start_time
  end
end
