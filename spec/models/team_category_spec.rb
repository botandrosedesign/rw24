require "ar_helper"
require "team_category"
load "db/seeds.rb"

describe TeamCategory do
  describe "validations" do
    it "requires name" do
      category = TeamCategory.new(min: 1, max: 1, initial: "X")
      category.should_not be_valid
      category.errors[:name].should be_present
    end

    it "requires min" do
      category = TeamCategory.new(name: "Test", max: 1, initial: "X")
      category.should_not be_valid
      category.errors[:min].should be_present
    end

    it "requires max" do
      category = TeamCategory.new(name: "Test", min: 1, initial: "X")
      category.should_not be_valid
      category.errors[:max].should be_present
    end

    it "requires initial" do
      category = TeamCategory.new(name: "Test", min: 1, max: 1)
      category.should_not be_valid
      category.errors[:initial].should be_present
    end

    it "validates uniqueness of name" do
      duplicate = TeamCategory.new(name: "A Team", min: 1, max: 1, initial: "X")
      duplicate.should_not be_valid
      duplicate.errors[:name].should be_present
    end

    it "is valid with all required attributes" do
      category = TeamCategory.new(name: "Unique Category", min: 1, max: 3, initial: "U")
      category.should be_valid
    end
  end

  describe ".model_name" do
    it "returns Category as the model name" do
      TeamCategory.model_name.name.should == "Category"
    end
  end

  describe "#key" do
    it "returns parameterized underscored name as symbol" do
      category = TeamCategory.find_by_name!("A Team")
      category.key.should == :a_team
    end

    it "handles multi-word names with parens" do
      category = TeamCategory.find_by_name!("Solo (male)")
      category.key.should == :solo_male
    end
  end

  describe "#range" do
    it "returns min..max range" do
      category = TeamCategory.find_by_name!("A Team")
      category.range.should eq(2..6)
    end

    it "returns single-value range for solo categories" do
      category = TeamCategory.find_by_name!("Solo (male)")
      category.range.should eq(1..1)
    end

    it "returns two-value range for tandem" do
      category = TeamCategory.find_by_name!("Tandem")
      category.range.should eq(2..2)
    end
  end
end
