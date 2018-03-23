class AddMiscFieldsToRiders < ActiveRecord::Migration[4.2]
  def self.up
    add_column :riders, :confirmed_on, :date
    add_column :riders, :notes, :text
  end

  def self.down
    remove_column :riders, :notes
    remove_column :riders, :confirmed_on
  end
end
