class Lap < ActiveRecord::Base
  belongs_to :team
  validates_presence_of :team
end
