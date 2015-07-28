class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  store :settings

  def self.published
    where(:published => true).order("year desc")
  end

  def self.current
    find_by_year(Date.today.year) || published.last
  end

  def running?
    started? and not finished?
  end

  def started?
    DateTime.now > start_time
  end

  def finished?
    DateTime.now > end_time
  end

  def end_time
    start_time + 24.hours
  end

  def start_time=(datetime)
    self.year = datetime.try(:year)
    super datetime
  end

  def bonuses
    settings[:bonuses] ||= []
  end

  def bonuses= value
    settings[:bonuses] = value
  end

  def bonus_checkpoints
    bonuses.map.with_index do |attributes, index|
      Bonus.new(attributes.merge(id: index))
    end
  end

  def assign_all_bonuses_bonuses
    total_points = bonus_checkpoints.map(&:points).map(&:to_i).sum
    tattoo_points = bonus_checkpoints.first.points.to_i
    raise AllBonusesException, "The first bonus needs to be a five point tattoo bonus" unless tattoo_points == 5
    all_bonuses_points = bonus_checkpoints.last.points.to_i
    raise AllBonusesException, "The last bonus needs to be a five point all bonuses bonus" unless all_bonuses_points == 5
    ideal_number = total_points - tattoo_points - all_bonuses_points

    teams.find_each.select do |team|
      team.bonuses_total == ideal_number
    end.each do |team|
      team.points.create!(qty: 5, category: "Bonus", race: self, bonus_id: bonus_checkpoints.last.id)
    end
  end

  def total_laps
    points.laps.sum(:qty)
  end

  def total_miles
    total_laps * BigDecimal.new("4.6")
  end
end

class AllBonusesException < StandardError; end
