class Team < ActiveRecord::Base
  TYPES = ["Solo", "Tandem", "Team A", "Team B"]
  has_many :laps, :order => "created_at"
  has_many :racers

  validates_presence_of :name, :number, :team_type
  validates_numericality_of :bonus_points

  def total_points
    laps.count + bonus_points.to_i
  end
end
