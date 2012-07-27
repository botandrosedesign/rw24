class AddSettingsToRaces < ActiveRecord::Migration
  def change
    add_column :races, :settings, :text
  end
end
