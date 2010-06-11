class Rider < ActiveRecord::Base
  belongs_to :team
  acts_as_list :scope => :team_id

  validates_presence_of :name
end
