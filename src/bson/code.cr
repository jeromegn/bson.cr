module BSON
  struct Code
    include BSON::Value

    property :javascript

    def initialize(@javascript = "")
    end

    def self.from_bson(bson : IO)
      new String.from_bson_bytes(bson.next_bytes(Int32.from_bson(bson)))
    end

    def to_bson(bson : IO)
      javascript.to_bson(bson)
    end

    def bson_size
      javascript.bson_size
    end

  end
end