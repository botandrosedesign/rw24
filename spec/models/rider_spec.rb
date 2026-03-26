require "ar_helper"
require "race"
require "team"
require "team_category"
require "rider"
require "support/factories"
load "db/seeds.rb"

describe Rider do
  let(:race) { FactoryBot.create(:race) }
  let(:team) { FactoryBot.create(:team_solo, race: race) }

  describe "associations" do
    it "belongs to a team" do
      rider = team.riders.first
      rider.team.should == team
    end

    it "optionally belongs to a user" do
      rider = team.riders.first
      rider.user_id.should be_nil
      rider.should be_valid
    end
  end

  describe "validations" do
    it "allows blank email" do
      rider = FactoryBot.build(:rider, email: "")
      rider.should be_valid
    end

    it "allows nil email" do
      rider = FactoryBot.build(:rider, email: nil)
      rider.should be_valid
    end

    it "validates email format when present" do
      rider = FactoryBot.build(:rider, email: "not-an-email")
      rider.should_not be_valid
    end

    it "accepts valid email" do
      rider = FactoryBot.build(:rider, email: "test@example.com")
      rider.should be_valid
    end
  end

  describe ".paid" do
    it "returns only paid riders" do
      paid_rider = team.riders.first
      paid_rider.update!(paid: true)
      unpaid_rider = FactoryBot.create(:rider, team: team, paid: false)

      Rider.paid.should include(paid_rider)
      Rider.paid.should_not include(unpaid_rider)
    end
  end

  describe "#team_position" do
    it "returns the team's position" do
      rider = team.riders.first
      rider.team_position.should == team.position
    end

    it "returns nil when team is nil" do
      rider = Rider.new
      rider.team_position.should be_nil
    end
  end

  describe "#shirt_size" do
    it "aliases shirt attribute" do
      rider = FactoryBot.build(:rider)
      rider.shirt = "XL"
      rider.shirt_size.should == "XL"
    end

    it "sets shirt via shirt_size=" do
      rider = FactoryBot.build(:rider)
      rider.shirt_size = "M"
      rider.shirt.should == "M"
    end
  end

  describe "acts_as_list" do
    it "scopes position to team" do
      rider1 = team.riders.first
      rider2 = FactoryBot.create(:rider, team: team)
      rider1.position.should == 1
      rider2.position.should == 2
    end
  end
end
