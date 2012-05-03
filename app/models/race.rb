class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  xss_terminate :except => :description

  def self.current
    Race.find_by_year Date.today.year
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
    super
  end
end
