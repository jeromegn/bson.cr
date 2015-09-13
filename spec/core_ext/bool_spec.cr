require "../spec_helper"

describe Bool do

  describe "#from_bson" do

    describe "when the boolean is true" do

      it "returns true" do
        io, writer = IO.pipe
        writer.write(UInt8[0x01])
        Bool.from_bson(io).should eq(true)
      end

    end

    describe "when the boolean is false" do

      it "returns false" do
        io, writer = IO.pipe
        writer.write(UInt8[0x00])
        Bool.from_bson(io).should eq(false)
      end

    end
  end
  
end
