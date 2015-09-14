require "../src/bson"

io = File.open(File.expand_path("examples/sample.bson"))

# until !(byte = io.read_byte)
#   puts "#{byte.inspect} (#{byte.not_nil!.chr.inspect})"
# end

# io = File.open(File.expand_path("examples/sample.bson"))

doc = BSON.parse(io)
puts doc

r, w = IO.pipe
doc.to_bson(w)

# until !(byte = r.read_byte)
#   puts "#{byte.inspect} (#{byte.not_nil!.chr.inspect})"
# end

puts BSON.parse(r)