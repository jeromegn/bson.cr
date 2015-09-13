class Regex

  def self.from_bson(bson : IO)

    source = bson.gets(0.chr).not_nil![0..-2]

    puts source.inspect

    byte = bson.read_byte
    options = Options::None
    unless byte == 0
      str = "#{byte.not_nil!.chr}#{bson.gets(0.chr).not_nil![0..-2]}"
      puts "options: #{str.inspect}"
      options |= Regex::Options::IGNORE_CASE if str.index('i')
      options |= Regex::Options::MULTILINE if str.index('m')
      options |= Regex::Options::EXTENDED if str.index('x')
      options |= Regex::Options::UTF_8 if str.index('u')
    end

    new(source, options)

  end

end