namespace :rw24 do
  task :import => [:import_2008, :import_2009]

  task :import_2008 => :environment do
    race = Race.find_by_year(2008)
    leaderboard_file = Rails.root.join "lib", "2008_leaderboard.html"
    doc = Nokogiri::HTML.parse File.read(leaderboard_file)
    doc.css("table")[0..-2].each_with_index do |table, i|
      rows = table.css("tr")[1..-1]
      rows.each do |row|
        categories = ["Solo (male)", "Tandem", "A Team", "B Team"]
        attrs = {
          :category => categories[i],
          :position => row.css("td:nth-child(1)").text,
          :name => row.css("td:nth-child(2)").text
        }
        team = race.teams.build(attrs)
        team.save(false)

        laps = row.css("td:nth-child(3)").text.to_i
        laps.times do
          team.points.create! :category => "Lap",
            :qty => 1,
            :race => race
        end

        bonus = row.css("td:nth-child(4)").text.to_i - laps
        team.points.create! :category => "Bonus", :qty => bonus, :race => race
      end
    end
  end

  task :import_2009 => :environment do
    race = Race.find_by_year(2009)
    leaderboard_file = Rails.root.join "lib", "2009_leaderboard.html"
    doc = Nokogiri::HTML.parse File.read(leaderboard_file)
    rows = doc.css("#stats tr")[1..-1]
    rows.each do |row|
      attrs = {
        :category => row.css("td:nth-child(1)").text,
        :position => row.css("td:nth-child(2)").text,
        :name => row.css("td:nth-child(3)").text
      }
      attrs[:category] = case attrs[:category]
        when "Team A" then "A Team"
        when "Team B" then "B Team"
        when "Solo" then "Solo (male)"
        else attrs[:category]
      end
      team = race.teams.build(attrs)
      team.save(false)

      laps = row.css("td:nth-child(4)").text.to_i
      laps.times do
        team.points.create! :category => "Lap",
          :qty => 1,
          :race => race
      end

      bonus = row.css("td:nth-child(5)").text.to_i
      team.points.create! :category => "Bonus", :qty => bonus, :race => race
    end
  end

  task :incorrect_all_bonuses => :environment do
    race = Race.find_by_year(2017)
    teams_with_all_bonuses_bonus = race.teams.select { |team| team.points.bonuses.last.bonus_id == 23 }
    teams_with_all_bonuses_bonus.select do |team|
      bonus_ids = team.points.bonuses.map(&:bonus_id)
      has_tattoo_bonus = bonus_ids.include?(0)
      doesnt_really_have_all_bonuses = bonus_ids.sort != (1..22).to_a
      has_tattoo_bonus || doesnt_really_have_all_bonuses
    end.each { |team| puts [team.position, team.name].to_s }
  end
end
