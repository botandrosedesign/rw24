require "ar_helper"
require "race"
require "team"
require "team_category"
require "rider"
require "point"
require "support/factories"
load "db/seeds.rb"

describe Point do
  describe "#last_lap" do
    before do
      @lap1 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.hour.ago
      @lap2 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 2.hours.ago
      @lap3 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.second.ago
    end

    it "returns the most recent lap" do
      @lap3.last_lap.should == @lap1
    end

    it "ignores laps by other teams" do
      Point.create! team_id: 2, qty: 1, category: "Lap", created_at: 1.hour.ago
      @lap3.last_lap.should == @lap1
    end

    it "ignores bonues" do
      Point.create! team_id: 2, qty: 1, category: "Bonus", created_at: 1.hour.ago
      @lap3.last_lap.should == @lap1
    end

    it "doesn't barf when there is only one lap" do
      @lap1.destroy
      @lap2.destroy

      start_time = 3.hours.ago
      @lap3.stub race: double(:race, start_time: start_time)
      @lap3.last_lap.created_at.should == start_time
    end
  end

  describe "#split_behind!" do
    before do
      @lap1 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.hour.ago
      @lap2 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 2.hours.ago
      @lap3 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.second.ago
    end

    it "creates a new lap that is halfway between itself and the previous lap" do
      new_lap = @lap3.split_behind!
      new_lap.created_at.should be_within(1).of(30.minutes.ago)
    end

    it "saves a new lap" do
      new_lap = @lap3.split_behind!
      Point.count.should == 4
    end
  end

  describe "#display_class" do
    before do
      @race = double(:race, start_time: 10.minutes.ago)
      @lap = Point.create!(team_id: 1, qty: 1, category: "Lap")
      @lap.stub race: @race
    end

    it "includes downcased category" do
      @race.stub start_time: 20.minutes.ago
      @lap.display_class.should == "lap"
    end

    it "includes impossible if since_last is under 14 minutes" do
      @lap.display_class.should == "lap impossible"
    end

    it "ignores impossible if not a lap" do
      @lap.category = "Bonus"
      @lap.display_class.should == "bonus"
    end
  end

  describe "CATEGORIES" do
    it "contains Lap, Bonus, and Penalty" do
      Point::CATEGORIES.should == %w(Lap Bonus Penalty)
    end
  end

  describe ".categories" do
    it "returns CATEGORIES" do
      Point.categories.should == Point::CATEGORIES
    end
  end

  describe ".laps" do
    it "returns only lap points" do
      lap = Point.create! team_id: 1, qty: 1, category: "Lap"
      bonus = Point.create! team_id: 1, qty: 5, category: "Bonus"
      Point.laps.should include(lap)
      Point.laps.should_not include(bonus)
    end
  end

  describe ".bonuses" do
    it "returns only bonus points" do
      lap = Point.create! team_id: 1, qty: 1, category: "Lap"
      bonus = Point.create! team_id: 1, qty: 5, category: "Bonus"
      Point.bonuses.should include(bonus)
      Point.bonuses.should_not include(lap)
    end
  end

  describe ".penalties" do
    it "returns only penalty points" do
      lap = Point.create! team_id: 1, qty: 1, category: "Lap"
      penalty = Point.create! team_id: 1, qty: -3, category: "Penalty"
      Point.penalties.should include(penalty)
      Point.penalties.should_not include(lap)
    end
  end

  describe ".new_lap" do
    it "creates a new lap with qty 1" do
      lap = Point.new_lap
      lap.category.should == "Lap"
      lap.qty.should == 1
    end

    it "accepts overrides" do
      lap = Point.new_lap(team_id: 5)
      lap.team_id.should == 5
      lap.category.should == "Lap"
    end
  end

  describe ".new_bonus" do
    it "creates a new bonus point" do
      bonus = Point.new_bonus(qty: 5)
      bonus.category.should == "Bonus"
      bonus.qty.should == 5
    end
  end

  describe ".new_penalty" do
    it "creates a new penalty point" do
      penalty = Point.new_penalty(qty: -3)
      penalty.category.should == "Penalty"
      penalty.qty.should == -3
    end
  end

  describe "validations" do
    it "validates category inclusion" do
      point = Point.new(team_id: 1, qty: 1, category: "Invalid")
      point.should_not be_valid
      point.errors[:category].should be_present
    end

    it "validates qty is numeric" do
      point = Point.new(team_id: 1, category: "Lap", qty: "abc")
      point.should_not be_valid
      point.errors[:qty].should be_present
    end

    it "validates laps must have qty of 1" do
      point = Point.new(team_id: 1, category: "Lap", qty: 2)
      point.should_not be_valid
      point.errors[:qty].should be_present
    end

    it "validates position must exist" do
      point = Point.new(category: "Lap", qty: 1)
      point.should_not be_valid
      point.errors[:team_position].should be_present
    end
  end

  describe "callbacks" do
    it "makes penalties negative" do
      point = Point.new(team_id: 1, category: "Penalty", qty: 3)
      point.valid?
      point.qty.should == -3
    end

    it "leaves already-negative penalties alone" do
      point = Point.new(team_id: 1, category: "Penalty", qty: -3)
      point.valid?
      point.qty.should == -3
    end

    it "makes bonuses positive" do
      point = Point.new(team_id: 1, category: "Bonus", qty: -5)
      point.valid?
      point.qty.should == 5
    end

    it "leaves already-positive bonuses alone" do
      point = Point.new(team_id: 1, category: "Bonus", qty: 5)
      point.valid?
      point.qty.should == 5
    end
  end

  describe "#since_start" do
    it "returns time since race start as HH:MM:SS" do
      race = FactoryBot.create(:race, start_time: Time.parse("2026-07-25 19:00:00"))
      team = FactoryBot.create(:team_solo, race: race)
      point = Point.create! race: race, team: team, category: "Lap", qty: 1,
        created_at: Time.parse("2026-07-25 20:30:45")
      point.since_start.should == "01:30:45"
    end

    it "returns nil when created_at is nil" do
      point = Point.new(category: "Lap", qty: 1)
      point.since_start.should be_nil
    end
  end

  describe "#since_start=" do
    it "sets created_at from HH:MM:SS string" do
      race = FactoryBot.create(:race, start_time: Time.parse("2026-07-25 19:00:00"))
      team = FactoryBot.create(:team_solo, race: race)
      point = Point.new(race: race, team: team, category: "Lap", qty: 1)
      point.since_start = "02:15:30"
      point.created_at.should == Time.parse("2026-07-25 21:15:30")
    end

    it "ignores invalid format" do
      race = FactoryBot.create(:race)
      point = Point.new(race: race, category: "Lap", qty: 1)
      point.since_start = "invalid"
      point.created_at.should be_nil
    end
  end

  describe "#since_last" do
    it "returns time since last lap" do
      race = FactoryBot.create(:race, start_time: Time.parse("2026-07-25 19:00:00"))
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1,
        created_at: Time.parse("2026-07-25 20:00:00")
      lap2 = Point.create! race: race, team: team, category: "Lap", qty: 1,
        created_at: Time.parse("2026-07-25 20:30:00")
      lap2.since_last.should == "00:30:00"
    end
  end

  describe "#team_position" do
    it "returns team position" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      point = Point.create! race: race, team: team, category: "Lap", qty: 1
      point.team_position.should == team.position
    end

    it "returns nil when team is nil" do
      point = Point.new(category: "Lap", qty: 1)
      point.team_position.should be_nil
    end
  end

  describe "#team_position=" do
    it "sets team by position and race" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      point = Point.new(race: race, category: "Lap", qty: 1)
      point.team_position = team.position
      point.team.should == team
    end
  end

  describe "#team_name" do
    it "returns team name" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race, name: "Speed Demons")
      point = Point.create! race: race, team: team, category: "Lap", qty: 1
      point.team_name.should == "Speed Demons"
    end

    it "returns nil when team is nil" do
      point = Point.new(category: "Lap", qty: 1)
      point.team_name.should be_nil
    end
  end

  describe "#total_laps" do
    it "counts laps for the same team and race" do
      race = FactoryBot.create(:race)
      team = FactoryBot.create(:team_solo, race: race)
      Point.create! race: race, team: team, category: "Lap", qty: 1
      lap2 = Point.create! race: race, team: team, category: "Lap", qty: 1
      Point.create! race: race, team: team, category: "Bonus", qty: 5
      lap2.total_laps.should == 2
    end
  end

  describe "category predicates" do
    it "#lap? returns true for laps" do
      Point.new(category: "Lap").should be_lap
    end

    it "#lap? returns false for non-laps" do
      Point.new(category: "Bonus").should_not be_lap
    end

    it "#bonus? returns true for bonuses" do
      Point.new(category: "Bonus").should be_bonus
    end

    it "#penalty? returns true for penalties" do
      Point.new(category: "Penalty").should be_penalty
    end
  end

  describe "#impossible?" do
    it "returns true when lap is under 14 minutes since last" do
      race = double(:race, start_time: 30.minutes.ago)
      Point.create!(team_id: 1, qty: 1, category: "Lap", created_at: 15.minutes.ago)
      lap2 = Point.create!(team_id: 1, qty: 1, category: "Lap", created_at: 5.minutes.ago)
      lap2.stub race: race
      lap2.should be_impossible
    end

    it "returns false when lap is over 14 minutes since last" do
      race = double(:race, start_time: 40.minutes.ago)
      Point.create!(team_id: 1, qty: 1, category: "Lap", created_at: 20.minutes.ago)
      lap2 = Point.create!(team_id: 1, qty: 1, category: "Lap", created_at: 1.minute.ago)
      lap2.stub race: race
      lap2.should_not be_impossible
    end

    it "returns false for non-laps" do
      Point.new(category: "Bonus", qty: 5).should_not be_impossible
    end
  end
end
