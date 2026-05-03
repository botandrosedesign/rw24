# This migration comes from adva_engine (originally 20161227203152)
class AddTimestampsToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :created_at, :timestamp
    add_column :categories, :updated_at, :timestamp
  end
end
