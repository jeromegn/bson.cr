module BSON
  struct CodeWithScope
    include BSON::Value

    getter :javascript, :scope

    def initialize(@javascript = "", @scope = Document.new)
    end

    def self.from_bson(bson : IO)
      bson.skip(4) # Throw away the total length.
      new String.from_bson(bson), Hash(String, BSON::Type).from_bson(bson)
    end

    def to_bson(bson : IO)
      bson_size.to_bson(bson)
      javascript.to_bson(bson)
      scope.to_bson(bson)
    end

    def bson_size
      4 + scope.bson_size + javascript.bson_size
    end

  end
end