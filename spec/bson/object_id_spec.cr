require "../spec_helper"

describe BSON::ObjectId do

  it ".from_bson" do
    io = MemoryIO.new
    t = Time.utc_now
    t.epoch.to_i32.to_bson(io)
    io.write(Slice(UInt8).new(8))
    oid = BSON::ObjectId.from_bson(io.rewind)
    oid.generation_time.should eq(Time.epoch(t.epoch))
    oid.to_s.size.should eq(24)
  end

  it "instantiate" do
    oid = BSON::ObjectId.new

    oid.to_s.size.should eq(24)
    oid.bytes.size.should eq(12)

    # first 4 bytes is seconds since unix epoch
    io = MemoryIO.new(oid.bytes[0,4])
    Int32.from_bson(io).should eq(Time.utc_now.epoch)
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