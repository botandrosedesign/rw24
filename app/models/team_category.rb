class TeamCategory < ActiveRecord::Base
  self.table_name = "team_categories"

  def self.model_name
    ActiveModel::Name.new(self, nil, "Category")
  end

  validates_uniqueness_of :name, case_sensitive: true
  validates_presence_of :name, :min, :max, :initial

  def key
    category.name.parameterize.underscore.to_sym 
  end

  def range
    min..max
  end
end

