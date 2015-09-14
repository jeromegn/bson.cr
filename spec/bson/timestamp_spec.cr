require "../spec_helper"

describe BSON::Timestamp do

  describe ".from_bson" do

    it "decodes to the correct time" do
      r,w = IO.pipe
      time = Time.utc_now
      
      1.to_i32.to_bson(w)
      time.epoch.to_bson(w)

      ts = BSON::Timestamp.from_bson(r)

      ts.time.epoch.should eq(time.epoch)
      ts.increment.should eq(1)
    end

  end

  describe "#to_bson" do

    it "encodes to the correct bytes" do
      time = Time.utc_now
      ts = BSON::Timestamp.new(1, time)

      r,w = IO.pipe
      ts.to_bson(w)

      Int32.from_bson(r).should eq(1)
      Int32.from_bson(r).should eq(time.epoch)
    end

  end

  describe "#bson_size" do

    it "is 8 bytes" do

      BSON::Timestamp.new(1, Time.now).bson_size.should eq(8)

    end

  end

end