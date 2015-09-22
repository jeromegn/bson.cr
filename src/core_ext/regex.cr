class Regex
  include BSON::Value

  def self.from_bson(bson : IO)

    source = bson.gets(BSON::NULL_BYTE.chr).not_nil!.chop

    byte = bson.read_byte
    options = Options::None
    unless byte == BSON::NULL_BYTE
      str = "#{byte.not_nil!.chr}#{bson.gets(BSON::NULL_BYTE.chr).not_nil!.chop}"
      options |= Regex::Options::IGNORE_CASE if str.index('i')
      options |= Regex::Options::MULTILINE if str.index('m')
    end

    new(source, options)

  end

  def to_bson(bson : IO)
    bson << source
    BSON.append_null_byte(bson)
    bson << "i" if options.includes?(Options::IGNORE_CASE)
    bson << "m" if options.includes?(Options::MULTILINE)
    BSON.append_null_byte(bson)
  end

  def bson_size
    size = source.bytesize
    size += 1 # null ending
    size += "i".bytesize if options.includes?(Options::IGNORE_CASE)
    size += "m".bytesize if options.includes?(Options::MULTILINE)
    size += 1 # null ending
  end

end