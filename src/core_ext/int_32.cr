struct Int32
  include BSON::Value
  
  def self.from_bson(bson : IO)
    bson.next_bytes(sizeof(Int32)).to_i32
  end

  def to_bson(bson : IO)
    to_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_slice
    slice = Slice(UInt8).new(sizeof(Int32))
    io = MemoryIO.new(slice)
    to_io(io, IO::ByteFormat::LittleEndian)
    slice
  end

  def bson_size
    sizeof(Int32)
  end

end