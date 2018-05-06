require "ar_helper"
require "shirt_sizes"

describe ShirtSizes do
  describe "#summary" do
    it "works" do
      subject.mens_small = 3
      subject.mens_xxx_large = 1
      subject.summary.should == "MS, MS, MS, MXXXL"
    end
  end
end
