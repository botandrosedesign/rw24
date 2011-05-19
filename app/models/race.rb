class Race < ActiveRecord::Base
  has_many :teams
  has_many :riders, :through => :teams
end
