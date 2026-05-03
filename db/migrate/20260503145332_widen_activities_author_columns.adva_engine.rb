# This migration comes from adva_engine (originally 20241224000005)
class WidenActivitiesAuthorColumns < ActiveRecord::Migration[7.0]
  def change
    change_column :activities, :author_name, :string, limit: 128
    change_column :activities, :author_email, :string, limit: 128
  end
end
