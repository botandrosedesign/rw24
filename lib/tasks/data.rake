namespace :data do
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

