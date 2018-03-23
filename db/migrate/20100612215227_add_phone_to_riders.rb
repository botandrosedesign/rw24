class AddPhoneToRiders < ActiveRecord::Migration[4.2]
  def self.up
    add_column :riders, :phone, :string
  end

  def self.down
    remove_column :riders, :phone
  end
end
