require 'fastercsv'

namespace :rw24 do
  task :import => :environment do
    FasterCSV.new(File.read("lib/2010_registration.csv"), :headers => true).each do |row|
      Team.find_or_create_by_name(row["team_name"]).update_attribute(:id, row["team_id"])
      team = Team.find row["team_id"]
      rider = Rider.new :team => team
      row.each do |key, value|
        rider.send "#{key}=".to_sym, value
      end
      if rider.name and rider.name.ends_with?("*")
        rider.move_to_top
        rider.name = rider.name[0..-2]
      end
      rider.save!
      rider.update_attribute :id, row["id"]
    end
  end
end
