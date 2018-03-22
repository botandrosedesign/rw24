require "ar_helper"
require "team"
require "./spec/support/factories"

describe Team do
  # stubbing #race is a bitch
  subject { FactoryBot.build(:team, race: nil) }
  let(:race) { double(marked_for_destruction?: false) }
  before { subject.stub(race: race) }

  context "of category 'A Team'" do
    before { subject.category = "A Team" }

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
    before { subject.category = "B Team" }

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
    before { subject.category = "Solo (male)" }

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
    before { subject.category = "Solo (female)" }

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
    before { subject.category = "Tandem" }

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
end
