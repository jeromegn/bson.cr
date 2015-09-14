class Array(T)

  def self.from_bson(bson : IO)
    size = Int32.from_bson(bson)

    arr = [] of BSON::ValueType

    byte = bson.read_byte
    until byte == BSON::NULL_BYTE
      type = BSON.type_for_byte(byte)
      index = bson.read_char
      bson.read_byte
      arr << type.from_bson(bson)
      byte = bson.read_byte
    end

    arr
  end

  def to_bson(bson : IO)
    BSON.logger.debug "Array to bson"
    BSON.logger.debug self
    bson_size.to_bson(bson)
    BSON.logger.debug "added size.."
    each_with_index do |value, index|
      BSON.logger.debug "Encoding array value of index #{index} (#{value.class})"
      bson.write(UInt8[BSON.byte_for_type(value.class)])
      BSON.logger.debug "wrote array value type..."
      bson << index.to_s
      BSON.logger.debug "write index number..."
      BSON.append_null_byte(bson)
      BSON.logger.debug "wrote null byte"
      value.to_bson(bson)
      BSON.logger.debug "wrote value!"
    end
    BSON.append_null_byte(bson)
  end

  def bson_size
    size = sizeof(Int32) # Size of the array
    each_with_index do |value, index|
      size += 1 + # one-byte type
        index.to_s.bytesize + # the index number's size
        1 + # null byte after each index
        value.bson_size
    end
    size += 1 # null byte

    # length + # Type of each key
    # [0..length - 1].map(&.to_s).sum(&.bytesize) + # Index number
    # length + # null byte for each index
    # sum(&.bson_size) +
    # 1 # null byte
  end

end