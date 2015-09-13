require "./spec_helper"

describe Bool do

  describe "#from_bson" do

    describe "when the boolean is true" do

      it "returns true" do
        Bool.from_bson(1.chr).should eq(true)
      end

    end

    describe "when the boolean is false" do

      it "returns false" do
        Bool.from_bson(0.chr).should eq(false)
      end

    end
  end
  
end
