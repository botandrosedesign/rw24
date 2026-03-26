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
    FactoryBot.create(:race).tap do |r|
      r.bonuses.create!(name: "Tattoo", points: 5, key: "tattoo")
      r.bonuses.create!(name: "Checkpoint 1", points: 2, key: "checkpoint-1")
      r.bonuses.create!(name: "Checkpoint 2", points: 2, key: "checkpoint-2")
    end
  end

  describe "#persisted?" do
    it "returns true when saved" do
      race.bonuses.first.should be_persisted
    end

    it "returns false when new" do
      bonus = Bonus.new
      bonus.should_not be_persisted
    end
  end

  describe "#new_record?" do
    it "returns false when saved" do
      race.bonuses.first.should_not be_new_record
    end

    it "returns true when new" do
      bonus = Bonus.new
      bonus.should be_new_record
    end
  end

  describe ".find_by_key" do
    it "finds a bonus by key" do
      race
      bonus = Bonus.find_by_key("checkpoint-2")
      bonus.name.should == "Checkpoint 2"
      bonus.race.should == race
    end

    it "raises when not found" do
      -> { Bonus.find_by_key("nonexistent") }.should raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
