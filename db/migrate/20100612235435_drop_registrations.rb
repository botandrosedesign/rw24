class DropRegistrations < ActiveRecord::Migration
  def self.up
    drop_table :registrations
    remove_column :teams, :registration_id
  end

  def self.down
    add_column :teams, :registration_id, :integer
    create_table "registrations", :force => true do |t|
      t.datetime "created_at"
      t.datetime "updated_at"
      t.integer  "year"
    end
  end
end
