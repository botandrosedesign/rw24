require "race"
require "rider"

class UserTeams
  def initialize
  end

  def [] value
    user_races_map[value]
  end

  def race_year_map
    @race_year_map ||= Hash[Race.pluck(:id, :year)]
  end

  def user_races_map
    @user_races_map ||= begin
      map = Hash.new { |hash, key| hash[key] = {} }
      Rider
        .where.not(user_id: nil)
        .includes(:team)
        .each do |rider|
          map[rider.user_id].merge!(rider.team.race_id => rider.team_id)
      end
      map
    end
  end
end

