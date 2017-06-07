module BSON
  struct DBPointer
    include BSON::Value
    @ref : BSON::ObjectId

    def initialize(@ref)
    end

    forward_missing_to @ref

    def self.from_bson(bson : IO)
      new ObjectId.from_bson(bson)
    end
  end
end
