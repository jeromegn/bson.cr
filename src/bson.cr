require "./core_ext/*"
require "./bson/*"

module BSON

  alias ValueType = Float64 | String | Document | Array(ValueType) | Binary | Undefined | ObjectId | Bool | Time | Nil | Regex | DBPointer | Code | Symbol | CodeWithScope | Int32 | Timestamp | Int64 | MinKey | MaxKey

  TYPES = Hash{
    1 => Float64,
    2 => String,
    3 => Document,
    4 => Array(ValueType),
    5 => Binary,
    6 => Undefined, # deprecated
    7 => ObjectId,
    8 => Bool,
    9 => Time,
    10 => Nil,
    0x0B => Regex,
    0x0C => DBPointer, # deprecated
    0x0D => Code,
    0x0E => Symbol, # deprecated
    0x0F => CodeWithScope,
    0x10 => Int32,
    0x11 => Timestamp,
    0x12 => Int64
    0xFF => MinKey, # internal
    0x7F => MaxKey # internal
  }

  TYPES_BY_CLASS = TYPES.invert

  NULL_BYTE = 0x00

  def self.append_null_byte(bson : IO)
    bson.write(UInt8[BSON::NULL_BYTE])
  end

  def self.parse(bson : IO)
    Document.from_bson(bson)
  end

  def self.key_from_bson(bson : IO)
    bson.gets(0.chr).not_nil!.chop
  end

  def self.type_for_byte(byte)
    TYPES[byte.not_nil!]
  end

  def self.byte_for_type(type)
    TYPES_BY_CLASS[type]
  end

end
