struct Float64

  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(8)
    bson.read(bytes)
    bytes.to_f64
  end

end