struct Bool

  BSON_TRUE_BYTE = 1
  BSON_FALSE_BYTE = 0

  def self.from_bson(bson : IO)
    bson.read_byte == BSON_TRUE_BYTE
  end

  def to_bson(bson : IO)
    bson.write_byte(self == true ? BSON_TRUE_BYTE : BSON_FALSE_BYTE)
  end

end