class TeamCategory < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :min, :max, :initial

  def key
    category.name.parameterize.underscore.to_sym 
  end

  def range
    min..max
  end
end

