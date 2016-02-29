require "../spec_helper"

describe Int64 do

  it ".from and #to" do
    [Int32::MAX + 1, Int64::MAX].map(&.to_i64).each do |i|
      Int64.from_bson(i.to_bson.rewind).should eq(i)
    end
  end
  
end