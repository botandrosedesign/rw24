class ChangeTeamsPositionToNotNull < ActiveRecord::Migration[8.0]
  def change
    change_column_null :teams, :position, false
  end
end
