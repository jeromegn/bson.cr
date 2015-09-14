module BSON
  class Binary

    getter :data, :type

    SUBTYPES = Hash{
      :generic => 0,
      :function => 1,
      :old => 2,
      :uuid_old => 3,
      :uuid => 4,
      :md5 => 5,
      :user => 128.chr
    }

    TYPES = SUBTYPES.invert

    def initialize(@data : Slice(UInt8), @type = :generic)
    end

    def self.from_bson(bson : IO)
      size = Int32.from_bson(bson)
      type = TYPES[bson.read_byte]
      size = Int32.from_bson(bson) if type == :old
      new(bson.next_bytes(size), type)
    end

    def to_bson(bson : IO)
      bson_size.to_bson(bson)
      bson.write(SUBTYPES[type])
      data.length.to_bson(bson) if old?
      bson.write(data)
    end

    def old?
      type == :old
    end

    def bson_size
      size = 4 + # size prefix
        1 + # subtype
        data.length # actual data size
      size += 4 if old?
    end

  end
end