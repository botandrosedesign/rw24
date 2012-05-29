class AddConfirmationSentAtToTeams < ActiveRecord::Migration
  def self.up
    add_column :teams, :confirmation_sent_at, :datetime
  end

  def self.down
    remove_column :teams, :confirmation_sent_at
  end
end
