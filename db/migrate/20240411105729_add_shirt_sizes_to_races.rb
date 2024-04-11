class AddShirtSizesToRaces < ActiveRecord::Migration[7.1]
  def change
    add_column :races, :shirt_sizes, :text
  end
end
