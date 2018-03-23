class AddSettingsToRaces < ActiveRecord::Migration[4.2]
  def change
    add_column :races, :settings, :text
  end
end
