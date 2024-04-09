require "ar_helper"
require "shirt_sizes"

describe ShirtSizes do
  describe "#summary" do
    it "works" do
      subject.small = 3
      subject.xxx_large = 1
      subject.summary.should == "S, S, S, XXXL"
    end
  end
end
