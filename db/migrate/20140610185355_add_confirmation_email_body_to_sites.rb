class AddConfirmationEmailBodyToSites < ActiveRecord::Migration[4.2]
  def change
    add_column :sites, :confirmation_email_body, :text
  end
end
