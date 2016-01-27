module BSON
  class Binary
    include BSON::Value

    getter :data, :type

    SUBTYPES = Hash{
      :generic => 0_u8,
      :function => 1_u8,
      :old => 2_u8,
      :uuid_old => 3_u8,
      :uuid => 4_u8,
      :md5 => 5_u8,
      :user => 128_u8
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
      data.size.to_bson(bson)
      bson.write_byte SUBTYPES[type]
      data.size.to_bson(bson) if old?
      bson.write(data)
    end

    def old?
      type == :old
    end

    def bson_size
      size = sizeof(Int32) + # size prefix
        1 + # subtype
        data.size # actual data size
      size += 4 if old? # if this is an old type binary
      size
    end

  end
end