require "../src/bson"

io = File.open(File.expand_path("examples/coll2.bson"))

puts BSON.parse(io)