class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  store :settings

  xss_terminate :except => :description

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

  def bonus_checkpoints
    bonuses.map.with_index do |attributes, index|
      Bonus.new(attributes.merge(id: index))
    end
  end

  def total_laps
    points.laps.sum(:qty)
  end

  def total_miles
    total_laps * BigDecimal.new("4.6")
  end
end
