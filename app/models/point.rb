class Point < ActiveRecord::Base
  CATEGORIES = %w(Lap Bonus Penalty)
  default_scope :order => "points.created_at ASC"

  belongs_to :team
  belongs_to :race

  validate :position_must_exist
  validates_inclusion_of :category, :in => CATEGORIES
  validates_numericality_of :qty

  before_validation :ensure_penalties_are_negative, :ensure_bonuses_are_positive

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

  def since_last(point)
    last = point ? point.created_at : race.start_time
    diff = created_at - last
    hours = diff / 1.hour
    minutes = diff % 1.hour / 1.minute
    seconds = diff % 1.minute
    [hours, minutes, seconds].collect{ |n| "%02d" % n }.join(":")
  end

  def lap_seconds
    last = Point.first :conditions => "team_id=#{team_id} AND category='Lap' AND created_at < '#{created_at}'", :order => "created_at DESC"
    last = last ? last.created_at : race.start_time
    created_at - last
  end

  def team_position
    team.try :position
  end

  def team_position=(value)
    self.team = Team.first :conditions => { :race_id => race_id, :position => value }
  end

  def team_name
    team.try :name
  end

  def total_laps
    Point.count(:conditions => "race_id=#{race.id} AND team_id=#{team_id} AND category='Lap'")
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
      errors.add(:team_position, "doesn't exist") unless team
    end
end
