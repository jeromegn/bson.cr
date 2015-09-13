struct Int64
  
  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(8)
    bson.read(bytes)
    bytes.to_i64
  end

end