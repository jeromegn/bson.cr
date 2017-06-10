module BSON
  struct Symbol
    include BSON::Value

    def initialize(@string = "")
    end

    forward_missing_to @string

    def self.from_bson(bson : IO)
      new String.from_bson(bson)
    end

    def inspect(io)
      io << ":#{@string}"
    end
  end
end
