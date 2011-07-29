class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  def self.current
    Race.find_by_year Date.today.year
  end
end
