class Lap < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team

  def team_number
    team && team.number
  end

  def team_number=(number)
    self.team = Team.find_by_number(number)
  end
end
