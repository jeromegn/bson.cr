require "../spec_helper"

describe BSON::Timestamp do

  describe ".from_bson" do

    it "decodes to the correct time" do
      io = StringIO.new
      time = Time.utc_now
      
      1.to_i32.to_bson(io)
      time.epoch.to_bson(io)

      ts = BSON::Timestamp.from_bson(io.rewind)

      ts.time.epoch.should eq(time.epoch)
      ts.increment.should eq(1)
    end

  end

  describe "#to_bson" do

    it "encodes to the correct bytes" do
      time = Time.utc_now
      ts = BSON::Timestamp.new(1, time)

      io = StringIO.new
      ts.to_bson(io)

      Int32.from_bson(io.rewind).should eq(1)
      Int32.from_bson(io).should eq(time.epoch)
    end

  end

  describe "#bson_size" do

    it "is 8 bytes" do

      BSON::Timestamp.new(1, Time.now).bson_size.should eq(8)

    end

  end

end