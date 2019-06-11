class CreateTeamCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :team_categories do |t|
      t.string :name
      t.integer :min, null: false
      t.integer :max, null: false
      t.string :initial
      t.timestamps
    end
  end
end
