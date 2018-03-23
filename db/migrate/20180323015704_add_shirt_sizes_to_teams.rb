class AddShirtSizesToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :shirt_sizes, :text
  end
end
