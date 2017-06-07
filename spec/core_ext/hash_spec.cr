require "../spec_helper"

describe Hash(String, BSON::Type) do
  describe "#to_bson" do
    it "encodes in the right format" do
      doc = {"ping" => 1}
      doc.bson_size.should eq(15)
      io = doc.to_bson
      Hash.from_bson(io.rewind)["ping"].should eq(1)
    end
  end
end
