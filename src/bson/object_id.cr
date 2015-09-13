module BSON
  class ObjectId

    def initialize(@bytes : Slice(UInt8))
    end

    def to_s
      @bytes.hexstring
    end

    def inspect(io)
      io << "ObjectId(\"#{to_s}\")"
    end

    def self.from_bson(bson : IO)
      bytes = Slice(UInt8).new(12)
      bson.read(bytes)
      new(bytes)
    end

  end
end