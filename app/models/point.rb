class Point < ActiveRecord::Base
  CATEGORIES = %w(Lap Bonus Penalty)
  default_scope -> { order(:created_at) }

  belongs_to :team
  belongs_to :race

  validate :position_must_exist
  validate :uniqueness_of_bonus
  validates_inclusion_of :category, :in => CATEGORIES
  validates_numericality_of :qty

  before_validation :ensure_penalties_are_negative, :ensure_bonuses_are_positive

  def self.laps
    where(category: "Lap")
  end

  def self.bonuses
    where(category: "Bonus")
  end

  def self.penalties
    where(category: "Penalty")
  end

  def self.categories
    CATEGORIES
  end

  def self.new_lap(attrs = nil)
    attrs ||= {}
    attrs.reverse_merge! :qty => 1, :category => "Lap"
    new attrs
  end

  def self.new_bonus(attrs = nil)
    attrs ||= {}
    attrs.reverse_merge! :category => "Bonus"
    new attrs
  end

  def self.new_penalty(attrs = nil)
    attrs ||= {}
    attrs.reverse_merge! :category => "Penalty"
    new attrs
  end

  def split_behind!
    dup.tap do |new_lap|
      diff = created_at - last_lap.created_at
      median = diff / 2
      new_lap.created_at = created_at - median.seconds
      new_lap.save!
    end
  end

  def since_start
    return unless created_at
    diff = created_at - race.start_time
    hours = diff / 1.hour
    minutes = diff % 1.hour / 1.minute
    seconds = diff % 1.minute
    [hours, minutes, seconds].collect{ |n| "%02d" % n }.join(":")
  end

  def since_start=(value)
    return unless value =~ /^\d+:\d+:\d+$/
    hours, minutes, seconds = value.split(":")
    self.created_at = race.start_time + hours.to_i.hours + minutes.to_i.minutes + seconds.to_i.seconds
  end

  def since_last(point=last_lap)
    diff = created_at - last_lap.created_at
    hours = diff / 1.hour
    minutes = diff % 1.hour / 1.minute
    seconds = diff % 1.minute
    [hours, minutes, seconds].collect{ |n| "%02d" % n }.join(":")
  end

  NullLap = Struct.new(:created_at)

  def last_lap
    last = Point.where(team_id: team_id, category: 'Lap').where(["created_at < ?", created_at]).reorder(created_at: :desc).first
    last || NullLap.new(race.start_time)
  end

  def lap_seconds
    created_at - last
  end

  def display_class
    classes = [category.downcase]
    classes << "impossible" if impossible?
    classes.compact.join(" ")
  end

  def impossible?
    return false unless lap?
    diff = created_at - last_lap.created_at
    diff < 14.minutes
  end

  def team_position
    team.try :position
  end

  def team_position=(value)
    self.team = Team.where(race_id: race_id, position: value).first
  end

  def team_name
    team.try :name
  end

  def total_laps
    Point.where(race_id: race.id, team_id: team_id, category: 'Lap').count
  end

  categories.each do |cat|
    define_method :"#{cat.downcase}?" do
      category == cat
    end
  end

  private

  def ensure_penalties_are_negative
    if category == "Penalty" && self.qty.try(:>, 0)
      self.qty = self.qty * -1
    end
  end

  def ensure_bonuses_are_positive
    if category == "Bonus" && self.qty.try(:<, 0)
      self.qty = self.qty.abs
    end
  end

  def position_must_exist
    errors.add(:team_position, "doesn't exist") unless team_id
  end

  def uniqueness_of_bonus
    if Point.where(:category => "Bonus", :team_id => team_id, :race_id => race_id, :bonus_id => bonus_id).count > 0
      errors.add(:team_position, "already has this bonus")
    end
  end
end
