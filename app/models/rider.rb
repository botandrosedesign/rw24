class Rider < ActiveRecord::Base
  def self.shirt_sizes
    %w(S M L XL)
  end

  named_scope :shirt, lambda { |size| { :conditions => { :shirt => size } } }
  named_scope :paid, :conditions => { :paid => true }

  belongs_to :team
  acts_as_list :scope => :team_id

  validates_email_format_of :email

  def team_category=(value)
    team.update_attribute :category, value
  end

  def team_name=(value)
    team.update_attribute :name, value
  end
end
