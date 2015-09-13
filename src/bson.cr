require "./core_ext/*"
require "./bson/*"

module BSON

  alias ValueType = Float64 | String | Array(ValueType) | Document | ObjectId | Bool | Time | Regex | Nil | Int32 | Int64

  TYPES_MAP = Hash{
    1 => Float64,
    2 => String,
    3 => Document,
    4 => Array,
    7 => ObjectId,
    6 => Nil, # Undefined (deprecated)
    8 => Bool,
    9 => Time,
    10 => Nil,
    0x0B => Regex,
    # 0x0C => DBRef, # Deprecated
    # 0x0D => Code,
    # 0x0E => Symbol, # Deprecated
    # 0x0F => CodeWithScope,
    0x10 => Int32,
    # 0x11 => Timestamp,
    0x12 => Int64,
    # 0xFF => MinKey,
    # 0x7F => MaxKey
  }

  def self.parse(bson : IO)
    Document.from_bson(bson)
  end

  def self.key_from_bson(bson : IO)
    String.build do |str|
      char = bson.read_char
      until char == 0.chr
        str << char
        char = bson.read_char
      end
      str
    end
  end

  def self.type_for_byte(byte)
    TYPES_MAP[byte.not_nil!]
  end

end
