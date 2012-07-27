class Bonus
  include ActiveModel::AttributeMethods
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  def self.find_by_race_and_key race, key
    race.bonuses.each_with_index do |bonus, index|
      next unless bonus[:key] == key
      return Bonus.new({ :id => index }.merge(bonus))
    end
    nil
  end

  attr_accessor :id, :name, :points, :key

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end
end
