require "../spec_helper"

describe Bool do
  describe ".from_bson" do
    describe "when the boolean is true" do
      it "returns true" do
        Bool.from_bson(true.to_bson.rewind).should eq(true)
      end
    end

    describe "when the boolean is false" do
      it "returns false" do
        Bool.from_bson(false.to_bson.rewind).should eq(false)
      end
    end
  end

  describe "#to_bson" do
    it "returns the true byte when true" do
      true.to_bson.rewind.read_byte.should eq(1)
    end

    it "returns the false byte when false" do
      false.to_bson.rewind.read_byte.should eq(0)
    end
  end
end
