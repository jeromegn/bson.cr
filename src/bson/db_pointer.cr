module BSON
  struct DBPointer
    include BSON::Value
    
    def initialize(@pointer = "")
    end
    forward_missing_to @pointer

    def self.from_bson(bson : IO)
      new ObjectId.from_bson(bson)
    end

  end
end