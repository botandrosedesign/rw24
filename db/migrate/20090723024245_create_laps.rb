class CreateLaps < ActiveRecord::Migration
  def self.up
    create_table :laps do |t|
      t.integer :team_id
      t.integer :lap

      t.timestamps
    end
  end

  def self.down
    drop_table :laps
  end
end
