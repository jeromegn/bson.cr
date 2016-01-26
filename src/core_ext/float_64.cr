struct Float64
  include BSON::Value

  def self.from_bson(bson : IO)
    bson.next_bytes(sizeof(Float64)).to_f64
  end

  def to_bson(bson : IO)
    to_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_slice
    slice = Slice(UInt8).new(sizeof(Float64))
    io = MemoryIO.new(slice)
    to_io(io, IO::ByteFormat::LittleEndian)
    slice
  end

  def bson_size
    sizeof(Float64)
  end

end