struct Float64
  include BSON::Value

  def self.from_bson(bson : IO)
    bson.next_bytes(8).to_f64
  end

  def to_bson(bson : IO)
    bson.write(bytes)
  end

  def bytes
    n = self
    Slice(UInt8).new(pointerof(n) as UInt8*, sizeof(typeof(n))).to_a
  end

end