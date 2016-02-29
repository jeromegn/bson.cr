struct Float
  include BSON::Value

  def self.from_bson(bson : IO)
    from_io(bson, IO::ByteFormat::LittleEndian)
  end

  def to_bson(bson : IO)
    to_io(bson, IO::ByteFormat::LittleEndian)
  end
end