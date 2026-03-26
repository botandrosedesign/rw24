require "active_record/json_associations"

class Race < ActiveRecord::Base
  belongs_to_many :categories, class_name: "TeamCategory"
  has_many :bonuses, -> { order(:position) }, class_name: "Bonus", dependent: :destroy
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

  def assign_all_bonuses_bonuses
    tattoo_bonus = bonuses.first
    raise AllBonusesException, "The first bonus needs to be a five point tattoo bonus" unless tattoo_bonus.points == 5
    all_bonuses_bonus = bonuses.last
    raise AllBonusesException, "The last bonus needs to be a five point all bonuses bonus" unless all_bonuses_bonus.points == 5

    middle_bonus_ids = bonuses.where.not(id: [tattoo_bonus.id, all_bonuses_bonus.id]).pluck(:id)

    teams.find_each do |team|
      assigned_bonus_ids = team.points.bonuses.pluck(:bonus_id)
      has_all_middle = (middle_bonus_ids - assigned_bonus_ids).empty?
      has_tattoo = assigned_bonus_ids.include?(tattoo_bonus.id)

      scope = team.points.where(qty: all_bonuses_bonus.points, category: "Bonus", race: self, bonus_id: all_bonuses_bonus.id)

      if has_all_middle && !has_tattoo
        scope.first_or_create!
      else
        scope.destroy_all
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

  def update_category(category, attributes)
    if other_race_uses_category?(category)
      new_category = TeamCategory.new(attributes)
      if new_category.save
        self.category_ids = category_ids.map { |id| id == category.id ? new_category.id : id }
        save!
      end
      new_category
    else
      category.update(attributes)
      category
    end
  end

  def other_race_uses_category?(category)
    Race.where.not(id: id).any? { |race| race.category_ids.include?(category.id) }
  end

  def rider_autocomplete_options
    user_team_map = riders.includes(:team).inject({}) do |map, rider|
      if rider.user_id
        map.merge rider.user_id => { pos: rider.team.position, name: rider.team.name }
      else
        map
      end
    end

    User.all.map do |user|
      team_info = user_team_map[user.id]
      {
        verified: user.verified?,
        label: "#{user.name} ‹#{user.email}›",
        value: user.id,
        user_id: user.id,
        name: user.name,
        email: user.email,
        phone: user.phone,
        shirt_size: user.shirt_size,
        team_pos: team_info&.dig(:pos),
        team_name: team_info&.dig(:name),
      }
    end
  end
end

class AllBonusesException < StandardError; end
