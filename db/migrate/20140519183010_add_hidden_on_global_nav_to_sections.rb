class AddHiddenOnGlobalNavToSections < ActiveRecord::Migration
  def change
    add_column :sections, :hidden_on_global_nav, :boolean, default: false
  end
end
