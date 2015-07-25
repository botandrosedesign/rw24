class Bonus
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def self.find_by_race_and_id race, id
    race.bonus_checkpoints.find do |bonus|
      bonus.id == id.to_i
    end
  end

  def self.find_by_race_and_key race, key
    race.bonus_checkpoints.find do |bonus|
      bonus.key == key
    end
  end

  attr_accessor :id, :name, :points, :key

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    id.present?
  end

  def new_record?
    !persisted?
  end
end
