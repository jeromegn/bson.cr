require "../spec_helper"

describe String do
  
  describe "#to_bson" do
    
    it "encodes in the right format" do

      str = "hello"
      r, w = IO.pipe
      str.to_bson(w)

      size = Int32.from_bson(r)
      size.should eq(str.bytesize + 1)

      r.next_bytes(size - 1).map(&.chr).join("").should eq(str)

      r.read_byte.should eq(BSON::NULL_BYTE)
    end

    it "can be decoded as BSON again" do
      str = "hello world"
      r, w = IO.pipe
      str.to_bson(w)
      String.from_bson(r).should eq(str)
    end

  end

end