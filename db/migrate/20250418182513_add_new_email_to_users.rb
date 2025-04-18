class AddNewEmailToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :new_email, :string
  end
end
