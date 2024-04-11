namespace :data do
  task :populate_race_shirt_sizes => :environment do
    Race.find_each do |race|
      case race.year
      when 2010..2017
        shirt_sizes = %w[S M L XL]
        key_map = {
          "small" => "S",
          "medium" => "M",
          "large" => "L",
          "x_large" => "XL",
        }

      when 2020..2023
        shirt_sizes = \
          %w[MS MM ML MXL MXXL MXXXL] +
          %w[WS WM WL WXL WXXL WXXXL]
        key_map = {
          "mens_small" => "MS",
          "mens_medium" => "MM",
          "mens_large" => "ML",
          "mens_x_large" => "MXL",
          "mens_xx_large" => "MXXL",
          "mens_xxx_large" => "MXXXL",
          "womens_small" => "WS",
          "womens_medium" => "WM",
          "womens_large" => "WL",
          "womens_x_large" => "WXL",
          "womens_xx_large" => "WXXL",
          "womens_xxx_large" => "WXXXL",
        }

      when 2024
        shirt_sizes = %w[XS S M L XL XXL XXXL]
        key_map = {}

      else
        shirt_sizes = []
        key_map = {}
      end

      puts "#{race.year}: #{shirt_sizes}"
      race.update! shirt_sizes: shirt_sizes

      race.teams.find_each do |team|
        team_shirt_sizes = JSON.load(team.shirt_sizes_before_type_cast).transform_keys(key_map).slice(*key_map.values)
        team_shirt_sizes.reverse_merge!(team.default_shirt_sizes)
        team.connection.update(<<~SQL)
          UPDATE teams SET
          shirt_sizes='#{team_shirt_sizes.to_json}'
          WHERE id=#{team.id}
        SQL
      end
    end
  end

  task :clear_shirt_sizes => :environment do
    User.update_all shirt_size: nil
  end

  task :fix_duplicate_team_positions => :environment do
    { 16 => 197 }.each do |race_id, position|
      race = Race.find(race_id)
      team = race.teams.where(position: position).last
      team.update!(position: race.teams.maximum(:position) + 1)
    end
  end

  task :populate_team_categories => :environment do
    # EXISTING
    #  [1, "A", "A Team"],
    #  [2, "B", "B Team"],
    #  [3, "E", "Elder Team"],
    #  [4, "S", "Solo (male)"],
    #  [5, "S", "Solo (female)"],
    #  [6, "S", "Solo (elder)"],
    #  [7, "T", "Tandem"],
    #  [8, "T", "Tandem (elder)"],
    #  [9, "C", "Convoy"],
    #  [10, "P", "Perfect Strangers"],

    # NEW
    #  [11, "S", "Solo (open)"],
    #  [12, "M", "Solo (M/T/NB)"],
    #  [13, "F", "Solo (F/T/NB)"],
    #  [14, "B", "Team"],
    ## [7,  "T", "Tandem"],
    ## [9,  "C", "Convoy"],
    #  [15, "E", "Elder"],
    ## [10, "P", "Perfect Strangers"],

    {
      2008 => [1,2,4,7],
      2009 => [1,2,4,7],
      2010 => [1,2,4,5,7],
      2011 => [1,2,4,5,7],
      2012 => [1,2,4,5,7],
      2013 => [1,2,4,5,7],
      2014 => [1,2,4,5,7],
      2015 => [1,2,4,5,7],
      2016 => [1,2,4,5,7],
      2017 => [1,2,4,5,7],
      2018 => [1,2,9,3,4,5,7],
      2019 => (1..10).to_a,
      2020 => (1..10).to_a,
      2021 => (1..10).to_a,
      2022 => (1..10).to_a,
      2023 => [11,12,13,14,7,9,15,10],
    }.each do |year, category_ids|
      Race.find_by_year(year).update! category_ids: category_ids
    end
  end

  task :strip_whitespace => :environment do
    User.find_each do |user|
      user.save!
    end
  end

  task :populate_verification_keys => :environment do
    User.find_each do |user|
      user.instance_eval do
        update_column :verification_key, hash_string(token_key)
      end
    end
  end

  task :remove_spam_accounts => :environment do
    User.where(verified_at: nil).where(shirt_size: "WXXXL").delete_all
  end

  task :migrate_shirt_sizes => :environment do
    blank_shirt_sizes = Team::ShirtSizes.new(small: 0, medium: 0, large: 0, x_large: 0, xxx_large: 0)
    Team.find_each do |team|
      team.shirt_sizes = team.riders.pluck(:shirt).inject(blank_shirt_sizes.dup) do |shirt_sizes, size|
        case size
        when "S" then shirt_sizes.small += 1
        when "M" then shirt_sizes.medium += 1
        when "L" then shirt_sizes.large += 1
        when "XL" then shirt_sizes.x_large += 1
        when "Other" then shirt_sizes.xxx_large += 1
        end
        shirt_sizes
      end
      team.save(validate: false)
    end
  end
end

