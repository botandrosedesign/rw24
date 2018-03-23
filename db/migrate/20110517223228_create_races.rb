class CreateRaces < ActiveRecord::Migration[4.2]
  def self.up
    create_table :races do |t|
      t.integer :year
    end
  end

  def self.down
    drop_table :races
  end
end
