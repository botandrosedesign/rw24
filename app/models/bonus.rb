require "positioning"

class Bonus < ActiveRecord::Base
  self.table_name = "bonuses"

  belongs_to :race

  positioned on: :race

  def self.find_by_key(key)
    find_by!(key: key)
  end

  def as_json(options = {})
    super(only: [:id, :name, :points, :key, :position])
  end
end
