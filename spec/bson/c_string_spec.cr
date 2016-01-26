require "../spec_helper"

describe BSON::CString do

  describe "#to_bson" do
    
    it "encodes in the right format" do
      str = "hello"
      cstr = BSON::CString.new(str)
      io = cstr.to_bson.rewind

      io.next_bytes(str.size).map(&.chr).join("").should eq(str)

      io.read_byte.should eq(0) # null ending
    end

  end

  describe ".from_bson" do
    it "can be decoded as BSON again" do
      str = "hello world"
      cstr = BSON::CString.new(str)
      BSON::CString.from_bson(cstr.to_bson.rewind).string.should eq(str)
    end
  end

end