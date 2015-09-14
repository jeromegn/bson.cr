class Regex

  def self.from_bson(bson : IO)

    source = bson.gets(BSON::NULL_BYTE.chr).not_nil!.chop

    byte = bson.read_byte
    options = Options::None
    unless byte == BSON::NULL_BYTE
      str = "#{byte.not_nil!.chr}#{bson.gets(BSON::NULL_BYTE.chr).not_nil!.chop}"
      options |= Regex::Options::IGNORE_CASE if str.index('i')
      options |= Regex::Options::MULTILINE if str.index('m')
      options |= Regex::Options::EXTENDED if str.index('x')
    end

    new(source, options)

  end

  def to_bson(bson : IO)
    bson << source
    BSON.append_null_byte(bson)
    bson << "i" if options.includes?(Options::IGNORE_CASE)
    bson << "ms" if options.includes?(Options::MULTILINE)
    bson << "x" if options.includes?(Options::EXTENDED)
    BSON.append_null_byte(bson)
  end

  def bson_size
    size = source.bytesize
    size += 1 # null ending
    size += 1 if options.includes?(Options::IGNORE_CASE)
    size += 1 if options.includes?(Options::MULTILINE)
    size += 1 if options.includes?(Options::EXTENDED)
    size += 1 # null ending
  end

end