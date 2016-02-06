module BSON
  struct Symbol
    include BSON::Value

    property :string

    def initialize(@string = "")
    end

    def self.from_bson(bson : IO)
      new String.from_bson_bytes(bson.next_bytes(Int32.from_bson(bson)))
    end

    def to_bson(bson : IO)
      string.to_bson(bson)
    end

    def bson_size
      string.bson_size
    end

  end
end