require "./bson/value"
require "./bson/*"
require "./core_ext/*"

module BSON
  extend self
  alias Type = Float64 |
               String |
               Hash(String, Type) |
               Array(Type) |
               BSON::Binary |
               BSON::Undefined |
               BSON::ObjectId |
               Bool |
               Time |
               Nil |
               Regex |
               BSON::DBPointer |
               BSON::Code |
               BSON::Symbol |
               Symbol |
               BSON::CodeWithScope |
               Int32 |
               BSON::Timestamp |
               Int64 |
               BSON::MinKey |
               BSON::MaxKey
  alias Document = Hash(String, Type)

  TYPES = Hash{
    0x01 => Float64,
    0x02 => String,
    0x03 => Document,
    0x04 => Array(Type),
    0x05 => BSON::Binary,
    0x06 => BSON::Undefined, # deprecated
    0x07 => BSON::ObjectId,
    0x08 => Bool,
    0x09 => Time,
    0x0A => Nil,
    0x0B => Regex,
    0x0C => BSON::DBPointer, # deprecated
    0x0D => BSON::Code,
    0x0E => BSON::Symbol, # deprecated
    0x0F => BSON::CodeWithScope,
    0x10 => Int32,
    0x11 => BSON::Timestamp,
    0x12 => Int64,
    0xFF => BSON::MinKey, # internal
    0x7F => BSON::MaxKey, # internal
  }

  TYPES_BY_CLASS = TYPES.invert

  def decode(bson : IO)
    Document.from_bson(bson)
  end

  def read_cstring(bson : IO)
    bson.gets(0x00).not_nil!.chop
  end

  def type_for_byte(byte)
    TYPES[byte.not_nil!]
  end

  def byte_for_type(type)
    TYPES_BY_CLASS[type]
  end
end
