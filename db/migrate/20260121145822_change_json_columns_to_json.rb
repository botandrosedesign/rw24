class ChangeJsonColumnsToJson < ActiveRecord::Migration[8.0]
  def change
    change_column :races, :category_ids, :json
  end
end
