require "validates_email_format_of"

class Rider < ActiveRecord::Base
  def self.shirt_sizes
    %w(S M L XL Other)
  end

  def self.shirt size
    where :shirt => size
  end

  def self.paid
    where :paid => true
  end

  belongs_to :team
  acts_as_list :scope => :team_id

  validates_email_format_of :email, :allow_blank => true

  def team_category=(value)
    team.update_attribute :category, value
  end

  def team_name=(value)
    team.update_attribute :name, value
  end

  def team_position
    team.try(:position)
  end
end
