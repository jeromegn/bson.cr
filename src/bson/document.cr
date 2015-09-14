module BSON
  class Document < Hash(String, BSON::ValueType)

    def id
      self["_id"]
    end

    def self.from_bson(bson : IO)
      size = Int32.from_bson(bson)
      puts "size == #{size}"

      doc = new
      
      byte = bson.read_byte
      until byte == BSON::NULL_BYTE
        type = BSON.type_for_byte(byte)
        puts "type for doc element: #{type}"
        key = BSON.key_from_bson(bson)
        puts "key: #{key}"
        doc[key] = type.from_bson(bson)
        puts doc
        byte = bson.read_byte
      end

      doc
    end

    def to_bson
      io = StringIO.new("")
      to_bson(io)
    end

    def to_bson(bson : IO)
      bson_size.to_bson(bson)
      each do |key, value|
        puts "Encoding key #{key} (#{value.class})"
        bson.write(UInt8[BSON.byte_for_type(value.class)])
        puts "Wrote type byte..."
        bson << key
        puts "Wrote key..."
        BSON.append_null_byte(bson)
        puts "Wrote null byte"
        value.to_bson(bson)
        puts "Wrote value to bson"
      end
      BSON.append_null_byte(bson)
    end

    def bson_size
      sizeof(Int32) + # doc size display
      keys.length + # each key shows a type
      keys.length + # each key as a null thing
      keys.sum {|k| puts "k: #{k} (#{k.bytesize} bytes)"; k.bytesize } + # all the keys size
      values.sum {|v| puts "v: #{v} (#{v.bson_size} bytes)"; v.bson_size } + # all the values size
      1 # null ending
    end

  end
end