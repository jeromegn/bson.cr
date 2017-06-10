class Hash(K, V)
  include BSON::Value

  def self.from_bson(bson : IO)
    size = Int32.from_bson(bson)

    doc = BSON::Document.new
    byte = bson.read_byte
    until byte == 0x00
      type = BSON.type_for_byte(byte)
      key = String.from_bson_cstring(bson)
      doc[key] = type.from_bson(bson)
      byte = bson.read_byte
    end

    doc
  end

  def to_bson(bson : IO)
    bson_size.to_bson(bson)
    each do |key, value|
      bson.write_byte(BSON.byte_for_type(value.class))
      key.to_s.to_bson_cstring(bson)
      value.to_bson(bson)
    end
    bson.write_byte(0x00)
  end

  def bson_size
    sizeof(Int32) +                      # doc size display
      (keys.size * 2) +                  # each key shows a type + null ending for each key
      keys.map(&.to_s).sum(&.bytesize) + # all the keys size
      values.sum(&.bson_size) +          # all the values size
      1                                  # null ending
  end
end
