module BSON
  struct DBPointer
    include BSON::Value
    
    getter :pointer

    def initialize(@pointer = "")
    end

    def self.from_bson(bson : IO)
      new String.from_bson_bytes(bson.next_bytes(Int32.from_bson(bson)))
    end

    def to_bson(bson : IO)
      pointer.to_bson(bson)
    end

    def bson_size
      pointer.bson_size
    end

  end
end