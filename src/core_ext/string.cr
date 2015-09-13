class String

  # Cast a String value from a BSON IO
  # 
  # First 4 bytes represent a Int32 (little-endian) for the 
  # size in bytes of the String
  # 
  # Ends with a null byte (0x00)
  def self.from_bson(bson : IO)
    size = bson.next_bytes(4).to_i32
    puts "string size: #{size} bytes"

    String.build do |str|
      bson.next_bytes(size).to_a[0..-2].each do |byte|
        str << byte.chr
      end
      str
    end
  end

  def to_bson(bson : IO)
    bson.write UInt8[bytesize + 1, 0x00, 0x00, 0x00] + to_slice.to_a + UInt8[0x00]
  end

end