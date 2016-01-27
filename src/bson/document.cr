module BSON
  class Document < Hash(String | Symbol | BSON::CString, BSON::ValueType)
    include BSON::Value

    def id
      self["_id"]
    end

    def self.from_bson(bson : IO)
      size = Int32.from_bson(bson)
      BSON.logger.debug "size == #{size}"

      doc = new
      
      byte = bson.read_byte
      until byte == BSON::NULL_BYTE
        type = BSON.type_for_byte(byte)
        BSON.logger.debug "type for doc element: #{type}"
        key = BSON.key_from_bson(bson)
        BSON.logger.debug "key: #{key}"
        doc[key] = type.from_bson(bson)
        BSON.logger.debug doc
        byte = bson.read_byte
      end

      doc
    end

    def to_bson(bson : IO)
      bson_size.to_bson(bson)
      each do |key, value|
        BSON.logger.debug "Encoding key #{key} (#{value.class})"
        bson.write(Slice(UInt8).new(1, BSON.byte_for_type(value.class)))
        BSON.logger.debug "Wrote type byte..."
        bson << key
        BSON.logger.debug "Wrote key..."
        BSON.append_null_byte(bson)
        BSON.logger.debug "Wrote null byte"
        value.to_bson(bson)
        BSON.logger.debug "Wrote value to bson"
      end
      BSON.append_null_byte(bson)
    end

    def keys
      super.map {|k| BSON::CString.new(k.to_s) }
    end

    def bson_size
      sizeof(Int32) + # doc size display
      keys.size + # each key shows a type
      keys.sum(&.bson_size) + # all the keys size
      values.sum(&.bson_size) + # all the values size
      1 # null ending
    end

  end
end