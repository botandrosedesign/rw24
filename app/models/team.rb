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

  default_scope :order => "position"

  attr_accessor :phone

  has_many :riders, :dependent => :delete_all
  belongs_to :site

  accepts_nested_attributes_for :riders, :reject_if => lambda { |attrs| attrs["name"].blank? }

  validates_presence_of :name, :category
  validates_presence_of :address, :city, :state, :zip, :on => :create
  validates_uniqueness_of :position
  validates_each :riders do |record, attr, value|
    record.errors.add attr, 'count is incorrect.' unless record.allowed_range.include? value.length
  end

  acts_as_list

  before_save :assign_phone_to_captain, :assign_site

  def initialize(attrs={})
    attrs ||= {}
    attrs.reverse_merge! "category" => "A Team"
    super
  end

  def allowed_range
    self.class.allowed_ranges[category.methodize.to_sym]
  end

  def captain
    riders.first
  end

  def category_abbrev
    category[0..0] if category
  end

  def category_abbrev_with_gender
    return category_abbrev unless category_abbrev == "S"
    category =~ /female/ ? "F" : "M"
  end

  def paid?
    riders.all?(&:paid?)
  end

  def partially_paid?
    not paid? and riders.any?(&:paid)
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
