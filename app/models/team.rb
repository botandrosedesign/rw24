require "acts_as_list"
require "shirt_sizes"

class Team < ActiveRecord::Base
  def self.allowed_ranges
    Category.all.to_a.reduce({}) do |hash, category|
      hash.merge category.key => category.range
    end
  end

  def self.legacy_categories
    Category.pluck(:name)
  end

  default_scope -> { order(:position) }
  
  def self.by_category category
    where(category: category)
  end

  attr_accessor :phone

  belongs_to :site
  belongs_to :race
  belongs_to :category, class_name: "TeamCategory"
  has_many :riders, dependent: :delete_all, inverse_of: :team
  accepts_nested_attributes_for :riders, reject_if: ->(attrs) { attrs["name"].blank? }, allow_destroy: true

  has_many :points

  serialize :shirt_sizes, ShirtSizes
  def shirt_sizes= value
    value = ShirtSizes.new(value) if value.is_a?(Hash)
    super
  end

  validates_presence_of :race, :name, :category
  validates_uniqueness_of :position, :scope => :race_id
  validates_each :riders do |record, attr, value|
    record.errors.add attr, "count is incorrect." unless record.allowed_range.include?(value.length)
  end

  acts_as_list :scope => :race_id

  before_save :assign_phone_to_captain, :assign_site

  def self.leader_board
    includes(:points).sort do |a,b|
      comp = a.points_total <=> b.points_total
      comp == 0 ? a.position <=> b.position : comp
    end.reverse
  end

  def self.send_confirmation_email_by_ids team_ids
    Team.where(id: team_ids).each do |team|
      team.delay.send_confirmation_email!
    end
  end

  delegate :year, to: :race, prefix: true

  def send_confirmation_email!
    Mailer.confirmation_email(self).deliver_now
    update_attribute :confirmation_sent_at, Time.now
  end

  def laps_total
    points.laps.sum(:qty)
  end

  def miles_total
    laps_total * BigDecimal("4.6")
  end

  def bonuses_total
    points.bonuses.sum(:qty)
  end

  def penalties_total
    points.penalties.sum(:qty)
  end

  def points_total
    points.sum(:qty)
  end

  def allowed_range
    category.range
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

  def category_initial
    category.initial
  end

  def legacy_category_initial_with_gender
    return "E" if category_name =~ /elder/i
    return category_initial unless category_initial == "S"
    category_name =~ /female/ ? "F" : "M"
  end

  def category_name
    category.name
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

  def has_bonus? bonus
    points.bonuses.map(&:bonus_id).include?(bonus.id)
  end

  def to_paypal_hash
    {
      :no_shipping => "1",
      :business => "riverwest24@gmail.com",
      :amount => 20.00,
      :quantity => riders.length,
      :item_name => "Riverwest 24 Registration - #{category.name}",
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
