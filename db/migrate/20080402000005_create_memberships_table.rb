class CreateMembershipsTable < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :site
      t.references :user
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
