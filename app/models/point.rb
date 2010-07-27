class Point < ActiveRecord::Base
  default_scope :order => "created_at DESC"

  belongs_to :team

  validates_presence_of :team_id, :category, :qty
  validates_numericality_of :qty

  before_validation :ensure_penalties_are_negative, :ensure_bonuses_are_positive

  def self.new_lap(attrs = nil)
    attrs ||= {}
    attrs.reverse_merge! :qty => 1, :category => "Lap"
    new attrs
  end

  def self.new_other(attrs = nil)
    attrs ||= {}
    attrs.reverse_merge! :qty => 1, :category => "Bonus"
    new attrs
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

  private
    def ensure_penalties_are_negative
      if category == "Penalty" && self.qty > 0
        self.qty = self.qty * -1
      end
    end

    def ensure_bonuses_are_positive
      if category == "Bonus" && self.qty < 0
        self.qty = self.qty.abs
      end
    end
end
