class Regex
  include BSON::Value

  def self.from_bson(bson : IO)
    source = String.from_bson_cstring(bson)
    byte = bson.read_byte
    options = Options::None
    opts_str = String.from_bson_cstring(bson)
    options |= Regex::Options::IGNORE_CASE if opts_str.index('i')
    options |= Regex::Options::MULTILINE if opts_str.index('m')
    new(source, options)
  end

  def to_bson(bson : IO)
    source.to_bson_cstring(bson)
    bson << "i" if options.includes?(Options::IGNORE_CASE)
    bson << "m" if options.includes?(Options::MULTILINE)
    bson.write_byte(0x00)
  end

  def bson_size
    size = source.bson_bytesize
    size += 1 if options.includes?(Options::IGNORE_CASE)
    size += 1 if options.includes?(Options::MULTILINE)
    size += 1 # null ending
  end

end