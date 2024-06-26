require "active_record/json_associations"

class Race < ActiveRecord::Base
  belongs_to_many :categories, class_name: "TeamCategory"
  has_many :teams
  has_many :riders, :through => :teams
  has_many :points

  store :settings

  serialize :shirt_sizes, coder: JSON, type: Array, default: %w[XS S M L XL XXL XXXL]

  def self.published
    where(published: true).order(year: :desc)
  end

  def self.current
    last
  end

  def running?
    started? and not finished?
  end

  def started?
    DateTime.now > start_time
  end

  def finished?
    DateTime.now > end_time
  end

  def end_time
    start_time + 24.hours
  end

  def bonuses
    settings[:bonuses] ||= []
  end

  def bonuses= value
    settings[:bonuses] = value
  end

  def bonus_checkpoints
    bonuses.map.with_index do |attributes, index|
      Bonus.new(attributes.merge(id: index))
    end
  end

  def assign_all_bonuses_bonuses
    tattoo_points = bonus_checkpoints.first.points.to_i
    raise AllBonusesException, "The first bonus needs to be a five point tattoo bonus" unless tattoo_points == 5
    all_bonuses_points = bonus_checkpoints.last.points.to_i
    raise AllBonusesException, "The last bonus needs to be a five point all bonuses bonus" unless all_bonuses_points == 5

    teams.find_each do |team|
      assigned_bonuses = team.points.bonuses.map(&:bonus_id).sort
      before = (1..bonus_checkpoints.count-2).to_a
      after = (1..bonus_checkpoints.count-1).to_a
      all_bonuses_bonus = team.points.where(qty: 5, category: "Bonus", race: self, bonus_id: bonus_checkpoints.last.id)

      if [before, after].include?(assigned_bonuses)
        all_bonuses_bonus.first_or_create!
      else
        all_bonuses_bonus.destroy_all
      end
    end
  end

  def total_laps
    points.laps.sum(:qty)
  end

  def total_miles
    total_laps * BigDecimal("4.6")
  end

  def shirt_size_counts
    teams.inject({}) do |counts, team|
      team.shirt_sizes.attributes.each do |size, count|
        counts[size.to_s] ||= 0
        counts[size.to_s] += count.to_i
      end
      counts
    end
  end

  def rider_autocomplete_options
    user_team_map = riders.includes(:team).inject({}) do |map, rider|
      if rider.user_id
        map.merge rider.user_id => rider.team.position
      else
        map
      end
    end

    User.all.map do |user|
      {
        verified: user.verified?,
        label: "#{user.name} ‹#{user.email}›",
        value: user.id,
        user_id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        shirt_size: user.shirt_size,
        team_pos: user_team_map[user.id],
      }
    end
  end
end

class AllBonusesException < StandardError; end
