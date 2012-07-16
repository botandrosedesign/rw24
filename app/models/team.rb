class Team < ActiveRecord::Base
  def self.allowed_ranges
    {
      :a_team      => 2..6,
      :b_team      => 2..6,
      :solo_male   => 1..1,
      :solo_female => 1..1,
      :tandem      => 2..2
    }
  end

  def self.categories
    ["A Team", "B Team", "Solo (male)", "Solo (female)", "Tandem"]
  end

  default_scope order("position")
  
  def self.by_category category
    where :category => category
  end

  attr_accessor :phone

  belongs_to :site
  belongs_to :race
  has_many :riders, :dependent => :delete_all
  has_many :points, :order => "created_at"

  accepts_nested_attributes_for :riders, :reject_if => lambda { |attrs| attrs["name"].blank? }

  validates_presence_of :race, :name, :category
  validates_uniqueness_of :position, :scope => :race_id
  validates_each :riders do |record, attr, value|
    record.errors.add attr, 'count is incorrect.' unless record.allowed_range.include? value.length
  end

  acts_as_list :scope => :race_id

  before_save :assign_phone_to_captain, :assign_site

  def self.leader_board
    all(:include => :points).sort do |a,b|
      comp = a.points_total <=> b.points_total
      comp == 0 ? a.position <=> b.position : comp
    end.reverse
  end

  def self.send_confirmation_email_by_ids team_ids
    return unless team_ids.present?
    team_ids.each do |id|
      team = Team.find_by_id id
      next unless team.present?
      if Rails.env.production?
        team.delay.send_confirmation_email!
      else
        team.send_confirmation_email!
      end
    end
  end

  def send_confirmation_email!
    Mailer.confirmation_email(self).deliver
    update_attribute :confirmation_sent_at, Time.now
  end

  def initialize *options, &block
    options[0] ||= {}
    options[0].reverse_merge! "category" => "A Team"
    super
  end

  def laps_total
    points.select(&:lap?).sum(&:qty)
  end

  def bonuses_total
    points.select(&:bonus?).sum(&:qty)
  end

  def penalties_total
    points.select(&:penalty?).sum(&:qty)
  end

  def points_total
    points.to_a.sum(&:qty)
  end

  def allowed_range
    self.class.allowed_ranges[category.methodize.to_sym]
  end

  def captain
    riders.first
  end

  def captain_email
    captain.email
  end

  def lieutenants
    riders - [captain]
  end

  def lieutenant_emails
    lieutenants.collect(&:email).select(&:present?).join(", ")
  end

  def shirt_sizes
    riders.collect(&:shirt).join(", ")
  end

  def category_abbrev
    category[0..0] if category
  end

  def category_abbrev_with_gender
    return category_abbrev unless category_abbrev == "S"
    category =~ /female/ ? "F" : "M"
  end

  def position_and_name
    "#{position} - #{name}"
  end

  def paid?
    riders.all?(&:paid?)
  end

  def partially_paid?
    not paid? and riders.any?(&:paid)
  end

  def emailed?
    confirmation_sent_at.present?
  end

  def to_paypal_hash
    {
      :no_shipping => "1",
      :business => "riverwest24@gmail.com",
      :amount => 20.00,
      :quantity => riders.length,
      :item_name => "Riverwest 24 Registration - #{category}",
      :cmd => "_xclick",
      :custom => id,
      :return => "http://riverwest24.com/join/articles/thanks",
      :notify_url => "http://riverwest24.com/join/registrations/payment",
      :shopping_url => "http://riverwest24.com",
      :cancel_return => "http://riverwest24.com",
      :upload => "1",
      :currency_code => "USD",
      :no_note => "1",
      :address_override => "1"
    }
  end

  private
    def assign_phone_to_captain
      captain.phone = self.phone if self.phone
    end

    def assign_site
      self.site = Site.first
    end
end
