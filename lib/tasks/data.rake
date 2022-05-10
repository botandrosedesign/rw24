namespace :data do
  task :remove_spam_accounts => :environment do
    User.where(verified_at: nil).where(shirt_size: "WXXXL").delete_all
  end

  task :populate_team_categories => :environment do
    Team.find_each do |team|
      begin
        team.update_column :category_id, TeamCategory.find_by_name!(team.legacy_category).id
      rescue ActiveRecord::RecordNotFound
        puts "Couldn't find TeamCategory with name: #{team.legacy_category}"
      end
    end
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

