require "ar_helper"
require "race"
require "team"
require "team_category"
require "rider"
require "point"
require "bonus"
require "support/factories"
load "db/seeds.rb"

describe Bonus do
  let(:race) do
    FactoryBot.create(:race, bonuses: [
      { "name" => "Tattoo", "points" => "5", "key" => "tattoo" },
      { "name" => "Checkpoint 1", "points" => "2", "key" => "checkpoint-1" },
      { "name" => "Checkpoint 2", "points" => "2", "key" => "checkpoint-2" },
    ])
  end

  describe "#initialize" do
    it "sets attributes from hash" do
      bonus = Bonus.new(name: "Test", points: 5, key: "test")
      bonus.name.should == "Test"
      bonus.points.should == 5
      bonus.key.should == "test"
    end

    it "handles empty attributes" do
      bonus = Bonus.new
      bonus.name.should be_nil
      bonus.id.should be_nil
    end
  end

  describe "#persisted?" do
    it "returns true when id is present" do
      bonus = Bonus.new(id: 1)
      bonus.should be_persisted
    end

    it "returns false when id is nil" do
      bonus = Bonus.new
      bonus.should_not be_persisted
    end
  end

  describe "#new_record?" do
    it "returns false when persisted" do
      bonus = Bonus.new(id: 1)
      bonus.should_not be_new_record
    end

    it "returns true when not persisted" do
      bonus = Bonus.new
      bonus.should be_new_record
    end
  end

  describe ".find_by_race_and_id" do
    it "finds a bonus by race and id" do
      bonus = Bonus.find_by_race_and_id(race, 0)
      bonus.name.should == "Tattoo"
    end

    it "finds bonus by string id" do
      bonus = Bonus.find_by_race_and_id(race, "1")
      bonus.name.should == "Checkpoint 1"
    end

    it "returns nil when not found" do
      bonus = Bonus.find_by_race_and_id(race, 99)
      bonus.should be_nil
    end
  end

  describe ".find_by_race_and_key" do
    it "finds a bonus by race and key" do
      bonus = Bonus.find_by_race_and_key(race, "checkpoint-1")
      bonus.name.should == "Checkpoint 1"
    end

    it "returns nil when not found" do
      bonus = Bonus.find_by_race_and_key(race, "nonexistent")
      bonus.should be_nil
    end
  end

  describe ".find_by_key" do
    it "finds a bonus across all races" do
      race # trigger lazy creation
      bonus = Bonus.find_by_key("checkpoint-2")
      bonus.name.should == "Checkpoint 2"
      bonus.race.should == race
    end
  end
end
