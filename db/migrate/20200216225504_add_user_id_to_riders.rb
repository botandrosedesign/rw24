class AddUserIdToRiders < ActiveRecord::Migration[5.2]
  def change
    add_reference :riders, :user, index: true
  end
end
