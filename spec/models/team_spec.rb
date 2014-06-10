require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Team do
  before do
    FactoryGirl.create :race
    @it = FactoryGirl.build :team
  end

  context "of category 'A Team'" do
    before do
      @it.category = "A Team"
    end

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should be_valid
      end
    end
  end

  context "of category 'B Team'" do
    before do
      @it.category = "B Team"
    end

    [0,1,7].each do |i|
      it "cannot have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should_not be_valid
      end
    end

    (2..6).each do |i|
      it "can have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should be_valid
      end
    end
  end

  context "of category 'Solo (male)'" do
    before do
      @it.category = "Solo (male)"
    end

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should_not be_valid
      end
    end

    it "can have 1 riders" do
      @it.riders << FactoryGirl.build(:rider)
      @it.should be_valid
    end
  end

  context "of category 'Solo (female)'" do
    before do
      @it.category = "Solo (female)"
    end

    [0,2,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should_not be_valid
      end
    end

    it "can have 1 riders" do
      @it.riders << FactoryGirl.build(:rider)
      @it.should be_valid
    end
  end

  context "of category 'Tandem'" do
    before do
      @it.category = "Tandem"
    end

    [0,1,3,4,5,6,7].each do |i|
      it "cannot have #{i} riders" do
        i.times { @it.riders << FactoryGirl.build(:rider) }
        @it.should_not be_valid
      end
    end

    it "can have 2 riders" do
      2.times { @it.riders << FactoryGirl.build(:rider) }
      @it.should be_valid
    end
  end
end
