class Team < ActiveRecord::Base
  def self.allowed_ranges
    {
      :a_team => 2..6,
      :b_team => 2..6,
      :solo   => 1..1,
      :tandem => 2..2
    }
  end

  attr_accessor :phone

  belongs_to :registration
  has_many :riders
  accepts_nested_attributes_for :riders, :reject_if => lambda { |attrs| attrs["name"].blank? }

  validates_presence_of :name, :category, :address, :city, :state, :zip
  validates_each :riders do |record, attr, value|
    record.errors.add attr, 'count is incorrect.' unless record.allowed_range.include? value.length
  end

  before_save :assign_phone_to_captain

  def initialize(attrs={})
    attrs.reverse_merge! "category" => "A Team"
    super
  end

  def allowed_range
    self.class.allowed_ranges[category.underscore.gsub(/ /,'_').to_sym]
  end

  def captain
    riders.first
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
end
