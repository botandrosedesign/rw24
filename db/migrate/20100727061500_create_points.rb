class CreatePoints < ActiveRecord::Migration[4.2]
  def self.up
    create_table :points do |t|
      t.integer :team_id
      t.integer :qty
      t.string :category

      t.timestamps
    end
  end

  def self.down
    drop_table :points
  end
end
