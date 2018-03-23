class AddHiddenOnGlobalNavToSections < ActiveRecord::Migration[4.2]
  def change
    add_column :sections, :hidden_on_global_nav, :boolean, default: false
  end
end
