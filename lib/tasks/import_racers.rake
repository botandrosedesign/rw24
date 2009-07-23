desc "Load racers and teams from db/racers.csv"
task :import_racers => :environment do
  require 'csv'
  require 'ruby-debug'

  Racer.destroy_all
  Team.destroy_all

  CSV::Reader.parse(File.open('db/racers.csv', 'rb')) do |row|
    next if row[0] !~ /^[0-9]+$/
    row.collect! {|value| value && value.strip }

    @team = Team.find_by_name row[5]
    unless @team
      team_type = row[3]
      team_map = {"s" => "Solo", "t" => "Tandem", "a" => "Team A", "b" => "Team B"}
      team_type = team_map[team_type]
      @team = Team.create :name => row[5], :number => row[2], :team_type => team_type
      raise @team.errors.inspect unless @team.valid?
    end

    begin
      payment_received_on = row[6] ? Date.parse(row[6]) : nil 
    rescue
      raise "Invalid payment received date: \"#{row[6]}\" for row: #{row.inspect}"
    end
    begin
      confirmed_on = row[10] ? Date.parse(row[10]) : nil
    rescue
      raise "Invalid confirmed date: \"#{row[10]}\" for row: #{row.inspect}"
    end

    @racer = Racer.create :name => row[1],
      :team => @team,
      :shirt => row[4],
      :payment_received_on => payment_received_on,
      :payment_type => row[7],
      :email => row[8],
      :phone => row[9],
      :confirmed_on => confirmed_on,
      :notes => row[11]
    raise @racer.errors.inspect unless @racer.valid?
  end
end

