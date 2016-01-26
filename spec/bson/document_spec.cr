require "../spec_helper"

describe BSON::Document do

  describe "#to_bson" do
    
    it "encodes in the right format" do
      doc = BSON::Document{"ping" => 1}
      doc.bson_size.should eq(15)
      io = doc.to_bson
      BSON::Document.from_bson(io.rewind)["ping"].should eq(1)
    end

  end

  # describe ".from_bson" do
  #   it "can be decoded as BSON again" do
  #     str = "hello world"
  #     cstr = BSON::CString.new(str)
  #     BSON::CString.from_bson(cstr.to_bson.rewind).string.should eq(str)
  #   end
  # end

end