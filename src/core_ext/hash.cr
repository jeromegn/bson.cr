class Hash(K, V)

  # def self.from_bson(bson : IO)

  #   size = bson.next_bytes(4).to_i32
  #   puts "hash size: #{size} bytes"

  #   hash = {} of String => BSON::Type

  #   byte = bson.read_byte
  #   until byte == 0x00
  #     type = BSON.type_for_byte(byte)
  #     puts "type for hash element: #{type}"
  #     key = BSON.key_from_bson(bson)
  #     puts "key: #{key}"
  #     hash[key] = type.from_bson(bson)
  #     puts hash
  #     byte = bson.read_byte
  #   end

  #   hash

  # end

end