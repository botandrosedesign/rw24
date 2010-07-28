class Point < ActiveRecord::Base
  CATEGORIES = %w(Lap Bonus Penalty)
  default_scope :order => "created_at DESC"

  belongs_to :team

  validates_presence_of :team_id, :message => "doesn't exist"
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
    diff = created_at - START_TIME
    hours = diff / 1.hour
    minutes = diff % 1.hour / 1.minute
    seconds = diff % 1.minute
    [hours, minutes, seconds].collect{ |n| "%02d" % n }.join(":")
  end

  def since_start=(value)
    return unless value =~ /^\d+:\d+:\d+$/
    hours, minutes, seconds = value.split(":")
    self.created_at = START_TIME + hours.to_i.hours + minutes.to_i.minutes + seconds.to_i.seconds
  end

  def team_position
    team.try :position
  end

  def team_position=(value)
    self.team = Team.find_by_position value
  end

  def team_name
    team.try :name
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
end
