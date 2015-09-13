struct Bool

  BSON_TRUE_BYTE = 0x01
  BSON_FALSE_BYTE = 0x00

  def self.from_bson(bson : IO)
    bson.read_byte == BSON_TRUE_BYTE
  end

  def to_bson(bson : IO)
    bson.write(UInt8[self == true ? BSON_TRUE_BYTE : BSON_FALSE_BYTE])
  end

end