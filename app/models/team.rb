class Team < ActiveRecord::Base
  TYPES = ["Solo", "Tandem", "Team A", "Team B"]
  has_many :laps
end
