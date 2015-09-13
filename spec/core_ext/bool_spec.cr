require "../spec_helper"

describe Bool do

  describe ".from_bson" do

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

  describe "#to_bson" do
    
    it "returns the true byte when true" do
      io, writer = IO.pipe
      true.to_bson(writer)
      io.read_byte.should eq(1)
    end

    it "returns the false byte when false" do
      io, writer = IO.pipe
      false.to_bson(writer)
      io.read_byte.should eq(0)
    end

  end
  
end
