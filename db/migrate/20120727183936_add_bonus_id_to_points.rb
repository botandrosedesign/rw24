class AddBonusIdToPoints < ActiveRecord::Migration
  def change
    add_column :points, :bonus_id, :integer
  end
end
