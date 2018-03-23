class CreateTeams < ActiveRecord::Migration[4.2]
  def self.up
    create_table :teams do |t|
      t.integer :registration_id
      t.string :name, :category, :address, :line_2, :phone, :shirts
      t.timestamps
    end
  end

  def self.down
    drop_table :teams
  end
end
