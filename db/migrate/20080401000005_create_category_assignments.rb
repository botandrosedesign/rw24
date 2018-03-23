class CreateCategoryAssignments < ActiveRecord::Migration[4.2]
  def self.up
    create_table :category_assignments do |t|
      t.references :content
      t.references :category
    end
  end

  def self.down
    drop_table :category_assignments
  end
end
