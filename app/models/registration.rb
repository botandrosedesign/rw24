class Registration < ActiveRecord::Base
  has_one :team
  accepts_nested_attributes_for :team

  def self.year
    2010
  end

  def initialize(attrs={})
    attrs[:year] ||= self.class.year
    super
  end

  def to_paypal_hash
    {
      :no_shipping => "1",
      :business => "riverwest24@gmail.com",
      :amount => 20.00,
      :quantity => team.riders.length,
      :item_name => "Riverwest 24 Registration - #{team.category}",
      :cmd => "_xclick",
      :custom => id,
      :return => "http://riverwest24.com/join/articles/thanks"
    }
  end
end
