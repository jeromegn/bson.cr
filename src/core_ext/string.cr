class String
  include BSON::Value

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

  def self.from_bson_cstring(bson : IO)
    (bson.gets(0x00.chr) || "").chomp(0x00.chr)
  end

  def self.from_bson_bytes(bytes)
    bytes.map(&.chr).join("").rchop
  end

  def to_bson(bson : IO)
    bson_bytesize.to_bson(bson)
    to_bson_cstring(bson)
  end

  def to_bson_cstring(bson : IO)
    bson.write(to_slice)
    bson.write_byte(0x00)
  end

  def to_bson_cstring
    io = IO::Memory.new
    to_bson_cstring(io)
    io
  end

  def bson_bytesize
    bytesize + 1
  end

  def bson_size
    sizeof(Int32) + # size of the String as a Int32
      bson_bytesize # actual bytes occupied by the String + null ending
  end
end
