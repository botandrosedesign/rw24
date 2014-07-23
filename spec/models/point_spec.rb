require "ar_helper"
require "point"

describe Point do
  describe "#last_lap" do
    before do
      @lap1 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.hour.ago
      @lap2 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 2.hours.ago
      @lap3 = Point.create! team_id: 1, qty: 1, category: "Lap", created_at: 1.minute.ago
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
end
