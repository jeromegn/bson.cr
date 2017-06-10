require "../spec_helper"

describe Float64 do
  describe ".from_bson" do
    it "returns a Float64" do
      [100, 2000, 30000, 400000].map(&.to_f64).each do |f|
        Float64.from_bson(f.to_bson.rewind).should eq(f)
      end
    end
  end

  describe "#to_bson" do
    it "puts the correct bytes" do
      [100, 2000, 30000, 400000].map(&.to_f64).each do |f|
        Float64.from_bson(f.to_bson.rewind).should eq(f)
      end
    end
  end
end
