require "ar_helper"
require "point"

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
end
