module BSON
  class CString
    include BSON::Value

    getter string
    def initialize(@string : String)
    end

    # Cast a CString value from a BSON IO
    # 
    # Ends with a null byte (0x00)
    def self.from_bson(bson : IO)
      self.new String.build do |str|
        byte = bson.read_byte
        until byte == BSON::NULL_BYTE
          str << byte.not_nil!.chr
          byte = bson.read_byte
        end
      end
    end

    def to_bson(bson : IO)
      bson.write(string.to_slice)
      BSON.append_null_byte(bson) # null ending
    end

    def bson_size
      string.bytesize + 1
    end

  end
end