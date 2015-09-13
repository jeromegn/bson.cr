struct Bool

  BSON_TRUE_BYTE = 1.chr

  def self.from_bson(bson : IO)
    bson.read_char == BSON_TRUE_BYTE
  end

end