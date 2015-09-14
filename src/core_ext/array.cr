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
    puts "Array to bson"
    puts self
    bson_size.to_bson(bson)
    puts "added size.."
    each_with_index do |value, index|
      puts "Encoding array value of index #{index} (#{value.class})"
      bson.write(UInt8[BSON.byte_for_type(value.class)])
      puts "wrote array value type..."
      bson.write(UInt8[index])
      puts "write index number..."
      BSON.append_null_byte(bson)
      puts "wrote null byte"
      value.to_bson(bson)
      puts "wrote value!"
    end
    BSON.append_null_byte(bson)
  end

  def bson_size
    sizeof(Int32) + # Size of the array
    length + # Type of each key
    [0..length - 1].map(&.to_s).sum(&.bytesize) + # Index number
    length + # null byte for each index
    sum(&.bson_size) +
    1 # null byte
  end

end