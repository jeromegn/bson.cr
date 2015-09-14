require "../spec_helper"

describe Float64 do

  describe ".from_bson" do

    it "returns a Float64" do
      f = 100.to_f64
      r, w = IO.pipe
      w.write(f.to_bytes)
      Float64.from_bson(r).should eq(f)
    end
    
  end

  describe "#to_bson" do

    it "puts the corrent bytes" do
      f = 200.to_f64
      r, w = IO.pipe
      f.to_bson(w)

      r.next_bytes(8).to_f64.should eq(200)
    end

  end
  
end