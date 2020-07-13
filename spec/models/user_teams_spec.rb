require "ar_helper"
require "user_teams"

describe UserTeams do
  before do
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO races (id, year) VALUES
        (1, 2015),
        (2, 2016),
        (3, 2017),
        (4, 2018),
        (5, 2019),
        (6, 2020);
    SQL
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO teams (id, race_id, position) VALUES
        (11, 1, 11),
        (22, 2, 22),
        (33, 3, 33),
        (44, 4, 44),
        (55, 5, 55),
        (66, 6, 66);
    SQL
    ActiveRecord::Base.connection.execute <<-SQL
      INSERT INTO riders (team_id, user_id) VALUES
        (11, 111),
        (22, 222),
        (33, 333),
        (44, 444),
        (55, 555),
        (66, 666);
    SQL
  end

  describe "#race_year_map" do
    it "works" do
      expect(subject.race_year_map).to eq({
        1 => 2015,
        2 => 2016,
        3 => 2017,
        4 => 2018,
        5 => 2019,
        6 => 2020,
      })
    end
  end

  describe "#user_races_map" do
    it "works" do
      expect(subject.user_races_map).to eq({
        111 => { 1 => 11 },
        222 => { 2 => 22 },
        333 => { 3 => 33 },
        444 => { 4 => 44 },
        555 => { 5 => 55 },
        666 => { 6 => 66 },
      })
    end
  end
end

