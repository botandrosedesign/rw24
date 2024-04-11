require "ar_helper"
require "shirt_sizes"

describe ShirtSizes do
  describe "#summary" do
    subject do
      ShirtSizes.load({
        "S": 0,
        "M": 0,
        "L": 0,
        "XL": 0,
      }.to_json)
    end

    it "works" do
      subject.S = 3
      subject.XL = 1
      subject.summary.should == "S, S, S, XL"
    end
  end
end
