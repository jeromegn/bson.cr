struct Int64
  
  def self.from_bson(bson : IO)
    bytes = Slice(UInt8).new(8)
    bson.read(bytes)
    bytes.to_i64
  end

  def to_bson(bson : IO)
    bson.write(to_slice)
  end

  def bytes
    {self, self >> 8, self >> 16, self >> 24, self >> 32, self >> 40, self >> 48, self >> 56}.map(&.to_u8)
  end

  def to_slice
    slice = Slice(UInt8).new(bytes.size)
    bytes.map(&.to_u8).each_with_index do |byte, i|
      slice[i] = byte
    end
    slice
  end

  def bson_size
    sizeof(typeof(Int64))
  end

end