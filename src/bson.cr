require "logger"
require "./bson/value"
require "./bson/*"
require "./core_ext/*"

module BSON
  extend self

  alias ValueType = Float64 | String | Document | Array(ValueType) | Binary | Undefined | ObjectId | Bool | Time | Nil | Regex | DBPointer | Code | Symbol | CodeWithScope | Int32 | Timestamp | Int64 | MinKey | MaxKey

  TYPES = Hash{
    1_u8 => Float64,
    2_u8 => String,
    3_u8 => Document,
    4_u8 => Array(ValueType),
    5_u8 => Binary,
    6_u8 => Undefined, # deprecated
    7_u8 => ObjectId,
    8_u8 => Bool,
    9_u8 => Time,
    10_u8 => Nil,
    0x0B_u8 => Regex,
    0x0C_u8 => DBPointer, # deprecated
    0x0D_u8 => Code,
    0x0E_u8 => Symbol, # deprecated
    0x0F_u8 => CodeWithScope,
    0x10_u8 => Int32,
    0x11_u8 => Timestamp,
    0x12_u8 => Int64,
    0xFF_u8 => MinKey, # internal
    0x7F_u8 => MaxKey # internal
  }

  TYPES_BY_CLASS = TYPES.invert

  NULL_BYTE = 0u8

  def append_null_byte(bson : IO)
    bson.write_byte(BSON::NULL_BYTE)
  end

  def decode(bson : IO)
    Document.from_bson(bson)
  end

  def key_from_bson(bson : IO)
    bson.gets(0.chr).not_nil!.chop
  end

  def type_for_byte(byte)
    TYPES[byte.not_nil!]
  end

  def byte_for_type(type)
    TYPES_BY_CLASS[type]
  end

  def logger
    @@logger ||= Logger.new(STDOUT)
  end

end

BSON.logger.level = Logger::INFO