class AddShirtToRiders < ActiveRecord::Migration[4.2]
  def self.up
    add_column :riders, :shirt, :string
    remove_column :teams, :shirts
  end

  def self.down
    add_column :teams, :shirts, :string
    remove_column :riders, :shirt
  end
end
