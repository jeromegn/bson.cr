struct Int
  include BSON::Value

  def self.from_bson(bson : IO)
    from_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_bson(bson : IO)
    to_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_slice
    slice = Slice(UInt8).new(sizeof(Int32))
    io = IO::Memory.new(slice)
    to_io(io, IO::ByteFormat::LittleEndian)
    slice
  end
end
