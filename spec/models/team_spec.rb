require "ar_helper"
require "team"
require "race"
require "team_category"
require "support/factories"
require_relative "../../db/seeds"

describe Team do
  # stubbing #race is a bitch
  subject { FactoryBot.build(:team) }

  context "of category 'A Team'" do
    before { subject.category = TeamCategory.find_by_name("A Team") }

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should be_valid
      end
    end
  end

  context "of category 'B Team'" do
    before { subject.category = TeamCategory.find_by_name("B Team") }

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should be_valid
      end
    end
  end

  context "of category 'Solo (male)'" do
    before { subject.category = TeamCategory.find_by_name("Solo (male)") }

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 1 riders" do
      subject.stub(riders: [double])
      subject.should be_valid
    end
  end

  context "of category 'Solo (female)'" do
    before { subject.category = TeamCategory.find_by_name("Solo (female)") }

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 1 riders" do
      subject.stub(riders: [double])
      subject.should be_valid
    end
  end

  context "of category 'Tandem'" do
    before { subject.category = TeamCategory.find_by_name("Tandem") }

    [0,1,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        subject.stub(riders: [double] * i)
        subject.should_not be_valid
      end
    end

    it "can have 2 riders" do
      subject.stub(riders: [double] * 2)
      subject.should be_valid
    end
  end

  describe "#shirt_sizes" do
    before do
      stub_const "Site", double(first: nil)
    end
    it "accepts a hash" do
      subject.shirt_sizes = {"small" => "1"}
      subject.shirt_sizes.small.should == 1
      subject.save(validate: false)
      subject.shirt_sizes.attributes.should == { "small" => 1 }
      subject.shirt_sizes.small.should == 1
    end
  end
end
