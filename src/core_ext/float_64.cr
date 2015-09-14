struct Float64

  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(8)
    bson.read(bytes)
    bytes.to_f64
  end

  def to_bson(bson : IO)
    bson.write(to_bytes)
  end

  def to_bytes(type = :little_endian)
    n = self
    Slice(UInt8).new(pointerof(n) as UInt8*, 8)
  end

  def bson_size
    sizeof(typeof(Float64))
  end

end