class MigrateRolesTableToNewRbac < ActiveRecord::Migration[4.2]
  def self.up
    rename_column :roles, :type, :name
    add_column :roles, :ancestor_context_id, :integer
    add_column :roles, :ancestor_context_type, :string
  end

  def self.down
    remove_column :roles, :ancestor_context_id
    remove_column :roles, :ancestor_context_type
    rename_column :roles, :name, :type
  end
end
