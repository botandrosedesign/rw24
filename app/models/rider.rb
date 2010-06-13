class Rider < ActiveRecord::Base
  def self.shirt_sizes
    %w(S M L XL)
  end

  belongs_to :team
  acts_as_list :scope => :team_id

  def team_category=(value)
    team.update_attribute :category, value
  end

  def team_name=(value)
    team.update_attribute :name, value
  end
end
