class Array(T)

  def self.from_bson(bson : IO)
    size = bson.next_bytes(4).to_i32
    puts "array size: #{size} bytes"

    arr = [] of BSON::ValueType

    byte = bson.read_byte
    until byte == 0x00
      type = BSON.type_for_byte(byte)
      puts "type for array element: #{type}"
      index = bson.read_char
      puts "index: #{index}"
      bson.read_byte
      arr << type.from_bson(bson)
      puts arr
      byte = bson.read_byte
    end

    arr
  end

end