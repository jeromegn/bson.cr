class Array(T)
  include BSON::Value

  def self.from_bson(bson : IO)
    size = Int32.from_bson(bson)

    arr = [] of BSON::Type

    byte = bson.read_byte
    until byte == 0x00
      type = BSON.type_for_byte(byte)
      index = bson.read_char
      bson.read_byte
      arr << type.from_bson(bson)
      byte = bson.read_byte
    end

    arr
  end

  def to_bson(bson : IO)
    bson_size.to_bson(bson)
    each_with_index do |value, index|
      bson.write_byte BSON.byte_for_type(value.class)
      bson << index.to_s
      bson.write_byte 0x00
      value.to_bson(bson)
    end
    bson.write_byte 0x00
  end

  def bson_size
    size = sizeof(Int32) # Size of the array
    each_with_index do |value, index|
      size += 1 +                   # one-byte type
              index.to_s.bytesize + # the index number's size
              1 +                   # null byte after each index
              value.bson_size
    end
    size += 1 # null byte
  end

  def as_slice
    Slice.new(to_unsafe, size)
  end
end
