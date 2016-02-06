module BSON
  struct CodeWithScope
    include BSON::Value

    getter :javascript, :scope

    def initialize(@javascript = "", @scope = Document.new)
    end

    def self.from_bson(bson : IO)
      bson.skip(4) # Throw away the total length.
      js = String.from_bson_bytes(bson.next_bytes(Int32.from_bson(bson)))
      scope = Document.from_bson(bson)
      new(js, scope)
    end

    def to_bson(bson : IO)
      bson_size.to_bson(bson)
      javascript.to_bson(bson)
      scope.to_bson(bson)
    end

    def bson_size
      4 + scope.bson_size + 4 + javascript.bson_size
    end

  end
end