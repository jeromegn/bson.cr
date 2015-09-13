require "../src/bson"

io = File.open(File.expand_path("examples/coll1.bson"))

puts BSON.parse(io)