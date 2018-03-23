class AddPaymentFieldsToRiders < ActiveRecord::Migration[4.2]
  def self.up
    add_column :riders, :paid, :boolean, :default => false
    add_column :riders, :payment_type, :string
    remove_column :registrations, :paid
  end

  def self.down
    add_column :registrations, :paid, :boolean, :default => false
    remove_column :riders, :payment_type
    remove_column :riders, :paid
  end
end
