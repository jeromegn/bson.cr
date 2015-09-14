class String

  # Cast a String value from a BSON IO
  # 
  # First 4 bytes represent a Int32 (little-endian) for the 
  # size in bytes of the String
  # 
  # Ends with a null byte (0x00)
  def self.from_bson(bson : IO)
    size = Int32.from_bson(bson)
    from_bson_bytes(bson.next_bytes(size))
  end

  def self.from_bson_bytes(bytes)
    bytes.map(&.chr).join("").chop
  end

  def to_bson(bson : IO)
    (bytesize + 1).to_bson(bson)
    bson.write(to_slice)
    BSON.append_null_byte(bson) # null ending
  end

  def bson_size
    sizeof(Int32) + # size of the String as a Int32
    bytesize + # actual bytes occupied by the String
    1 # null byte endings
  end

end