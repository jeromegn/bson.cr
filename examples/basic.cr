require "../src/bson"

# Sample looks like from the mongo shell:
# {
#   "_id" : ObjectId("55f6f36d8c37edc21c37ba22"),
#   "bool" : true,
#   "date" : ISODate("2015-09-14T16:18:53.358Z"),
#   "str" : "this is a string",
#   "int" : 12345,
#   "float" : 10.5,
#   "nulll" : null,
#   "false_bool" : false,
#   "arr" : [
#     "woot",
#     123,
#     true,
#     ObjectId("55f493a245e0d9101ccba987"),
#     {
#       "ok" : 1
#     }
#   ],
#   "embedded" : {
#     "sweeeet" : "sweet",
#     "num" : 12345678912235672000
#   },
#   "regex" : /^blHHSD[asdasd](s\d*)/gi,
#   "bin" : BinData(0,"c9f0f895fb98ab9159f51fd0297e236d"),
#   "ts" : Timestamp(1442247533, 1),
#   "undef" : null
# }

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