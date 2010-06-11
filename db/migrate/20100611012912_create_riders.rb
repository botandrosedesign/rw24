class CreateRiders < ActiveRecord::Migration
  def self.up
    create_table :riders do |t|
      t.integer :team_id
      t.string :name, :email
      t.integer :position
      t.timestamps
    end
  end

  def self.down
    drop_table :riders
  end
end
