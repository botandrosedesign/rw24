require "validates_email_format_of"

class Rider < ActiveRecord::Base
  def self.paid
    where(paid: true)
  end

  belongs_to :team
  acts_as_list scope: :team_id

  validates_email_format_of :email, allow_blank: true

  def team_position
    team.try(:position)
  end
end
