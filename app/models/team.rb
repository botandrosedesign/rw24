class Team < ActiveRecord::Base
  belongs_to :registration
  has_many :riders
  accepts_nested_attributes_for :riders, :reject_if => lambda { |attrs| attrs["name"].blank? }

  def initialize(attrs={})
    attrs[:category] ||= "A Team"
    super
  end
end
