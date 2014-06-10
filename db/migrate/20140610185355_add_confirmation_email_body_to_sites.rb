class AddConfirmationEmailBodyToSites < ActiveRecord::Migration
  def change
    add_column :sites, :confirmation_email_body, :text
  end
end
