struct Int32
  
  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(4)
    bson.read(bytes)
    bytes.to_i32
  end

end