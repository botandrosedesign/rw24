class Team < ActiveRecord::Base
  def self.allowed_ranges
    {
      :a_team => 2..6,
      :b_team => 2..6,
      :solo   => 1..1,
      :tandem => 2..2
    }
  end

  belongs_to :registration
  has_many :riders
  accepts_nested_attributes_for :riders, :reject_if => lambda { |attrs| attrs["name"].blank? }

  validates_presence_of :name, :category, :address, :city, :state, :zip, :phone
  validates_each :riders do |record, attr, value|
    record.errors.add attr, 'count is incorrect.' unless record.allowed_range.include? value.length
  end

  serialize :shirts

  def initialize(attrs={})
    attrs.reverse_merge! "category" => "A Team"
    super
  end

  def allowed_range
    self.class.allowed_ranges[category.underscore.gsub(/ /,'_').to_sym]
  end
end
