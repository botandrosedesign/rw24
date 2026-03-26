require "ar_helper"
require "state"

describe State do
  describe "NAMES" do
    it "contains 52 entries (50 states + DC + Puerto Rico)" do
      State::NAMES.length.should == 52
    end

    it "contains [name, abbreviation] pairs" do
      State::NAMES.each do |entry|
        entry.length.should == 2
        entry.first.should be_a(String)
        entry.second.should be_a(String)
        entry.second.length.should == 2
      end
    end

    it "includes Wisconsin" do
      State::NAMES.should include(["Wisconsin", "WI"])
    end

    it "includes DC" do
      State::NAMES.should include(["District Of Columbia", "DC"])
    end

    it "includes Puerto Rico" do
      State::NAMES.should include(["Puerto Rico", "PR"])
    end
  end

  describe ".abbrevs" do
    it "returns an array of state abbreviations" do
      abbrevs = State.abbrevs
      abbrevs.should be_an(Array)
      abbrevs.length.should == 52
      abbrevs.should include("WI", "CA", "NY", "DC", "PR")
    end
  end
end
