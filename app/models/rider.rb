class Rider < ActiveRecord::Base
  def self.shirt_sizes
    %w(S M L XL)
  end

  belongs_to :team
  acts_as_list :scope => :team_id

  validates_presence_of :name
end
