module BSON
  module Specialized

    def to_bson(bson : IO)
      # Do nothing
    end

    def bson_size
      0
    end

    module ClassMethods
      def from_bson(bson : IO)
        new
      end
    end

  end
end