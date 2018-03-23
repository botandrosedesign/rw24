class AddShirtSizesToTeams < ActiveRecord::Migration[4.2]
  def change
    add_column :teams, :shirt_sizes, :text
  end
end
