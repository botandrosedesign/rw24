require "positioning"
require "validates_email_format_of"
require "team"

class Rider < ActiveRecord::Base
  def self.paid
    where(paid: true)
  end

  belongs_to :team
  belongs_to :user, required: false
  positioned on: :team

  validates_email_format_of :email, allow_blank: true

  def team_position
    team.try(:position)
  end

  alias_attribute :shirt_size, :shirt
end
