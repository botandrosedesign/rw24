class AddStartTimeToRaces < ActiveRecord::Migration[4.2]
  def self.up
    add_column :races, :start_time, :datetime
  end

  def self.down
    remove_column :races, :start_time
  end
end
