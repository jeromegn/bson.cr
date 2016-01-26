struct Int64
  
  def self.from_bson(bson : IO)
    bson.next_bytes(sizeof(Int64)).to_i64
  end

  def to_bson(bson : IO)
    to_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_slice
    slice = Slice(UInt8).new(sizeof(Int64))
    io = MemoryIO.new(slice)
    to_io(io, IO::ByteFormat::LittleEndian)
    slice
  end

  def bson_size
    sizeof(Int64)
  end

end