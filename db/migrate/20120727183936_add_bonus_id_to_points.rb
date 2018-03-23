class AddBonusIdToPoints < ActiveRecord::Migration[4.2]
  def change
    add_column :points, :bonus_id, :integer
  end
end
