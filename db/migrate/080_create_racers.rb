class CreateRacers < ActiveRecord::Migration
  def self.up
    create_table :racers do |t|
      t.string :name
      t.integer :team_id
      t.string :shirt
      t.date :payment_received_on
      t.string :payment_type
      t.string :email
      t.string :phone
      t.date :confirmed_on                              
      t.string :notes
    end
  end

  def self.down
    drop_table :racers
  end
end
