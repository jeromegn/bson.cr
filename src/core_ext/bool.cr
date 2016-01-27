struct Bool
  include BSON::Value

  BSON_TRUE_BYTE = 0x01_u8
  BSON_FALSE_BYTE = 0x00_u8

  def self.from_bson(bson : IO)
    bson.read_byte == BSON_TRUE_BYTE
  end

  def to_bson(bson : IO)
    bson.write_byte bson_byte
  end

  def bson_byte
    self == true ? BSON_TRUE_BYTE : BSON_FALSE_BYTE
  end

  def bson_size
    1
  end

end