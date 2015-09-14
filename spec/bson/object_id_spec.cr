require "../spec_helper"

describe BSON::ObjectId do

  it ".from_bson" do
    r,w = IO.pipe
    t = Time.utc_now
    t.epoch.to_i32.to_bson(w)
    w.write(Slice(UInt8).new(8))
    oid = BSON::ObjectId.from_bson(r)
    oid.generation_time.should eq(Time.epoch(t.epoch))
    oid.to_s.length.should eq(24)
  end

  it "instantiate" do
    oid = BSON::ObjectId.new

    oid.to_s.length.should eq(24)
    oid.bytes.length.should eq(12)

    # first 4 bytes is seconds since unix epoch
    oid.bytes[0,4].to_i32.should eq(Time.utc_now.epoch)
  end

  it "==" do
    (BSON::ObjectId.new == BSON::ObjectId.new).should be_false
    oid = BSON::ObjectId.new
    (oid == oid).should be_true
  end

  it "generation_time" do
    BSON::ObjectId.new.generation_time.should be_a(Time)
  end

end