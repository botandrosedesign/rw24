class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  store :settings

  xss_terminate :except => :description

  def self.published
    order("year desc").select(&:started?)
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
end
