require "../src/bson"
require "benchmark"

count = 1_000_000
Benchmark.bm do |bench|

  bson_file = File.open(File.expand_path("examples/sample.bson"))

  document = BSON.decode(bson_file)

  bson = StringIO.new

  bench.report("Document#to_bson ------>") do
    count.times { document.to_bson(bson) }
  end

  bson.clear
  bench.report("Binary#to_bson -------->") do
    count.times { BSON::Binary.new("test".to_slice, :generic).to_bson(bson) }
  end

  bson.clear
  bench.report("Code#to_bson ---------->") do
    count.times { BSON::Code.new("this.value = 1").to_bson(bson) }
  end

  bson.clear
  bench.report("FalseClass#to_bson ---->") do
    count.times { false.to_bson(bson) }
  end

  bson.clear
  bench.report("Float64#to_bson --------->") do
    count.times { 1.131312.to_bson(bson) }
  end

  bson.clear
  bench.report("Int32#to_bson ------->") do
    count.times { 1024.to_bson(bson) }
  end

  bson.clear
  bench.report("Int64#to_bson ------->") do
    count.times { Int64::MAX.to_bson(bson) }
  end

  bson.clear
  bench.report("MaxKey#to_bson -------->") do
    count.times { BSON::MaxKey.new.to_bson(bson) }
  end

  bson.clear
  bench.report("MinKey#to_bson -------->") do
    count.times { BSON::MinKey.new.to_bson(bson) }
  end

  bson.clear
  bench.report("ObjectId#to_bson ------>") do
    count.times { BSON::ObjectId.new.to_bson(bson) }
  end

  bench.report("ObjectId#to_s --------->") do
    object_id = BSON::ObjectId.new
    count.times { object_id.to_s }
  end

  bson.clear
  bench.report("Regexp#to_bson -------->") do
    count.times { %r{\d+}.to_bson(bson) }
  end

  bson.clear
  bench.report("String#to_bson -------->") do
    count.times { "testing".to_bson(bson) }
  end

  bson.clear
  bench.report("Symbol#to_bson -------->") do
    count.times { "testing".to_bson(bson) }
  end

  bson.clear
  bench.report("Time#to_bson ---------->") do
    count.times { Time.new.to_bson(bson) }
  end

  bson.clear
  bench.report("TrueClass#to_bson ----->") do
    count.times { true.to_bson(bson) }
  end

  boolean_bytes = StringIO.new
  true.to_bson(boolean_bytes)
  bench.report("Boolean#from_bson ----->") do
    count.times { boolean_bytes.rewind; Bool.from_bson(boolean_bytes) }
  end

  int32_bytes = StringIO.new
  1024.to_bson(int32_bytes)
  bench.report("Int32#from_bson ------->") do
    count.times { int32_bytes.rewind; Int32.from_bson(int32_bytes) }
  end

  int64_bytes = StringIO.new
  Int64::MAX.to_bson(int64_bytes)
  bench.report("Int64#from_bson ------->") do
    count.times { int64_bytes.rewind; Int64.from_bson(int64_bytes) }
  end

  float64_bytes = StringIO.new
  Float64::MAX.to_bson(float64_bytes)
  bench.report("Float64#from_bson ------->") do
    count.times { float64_bytes.rewind; Float64.from_bson(float64_bytes) }
  end

  binary_bytes = StringIO.new
  BSON::Binary.new("test".to_slice).to_bson(binary_bytes)
  bench.report("Binary#from_bson ------>") do
    count.times { binary_bytes.rewind; BSON::Binary.from_bson(binary_bytes) }
  end

  code_bytes = StringIO.new
  BSON::Code.new("this.value = 1").to_bson(code_bytes)
  bench.report("Code#from_bson -------->") do
    count.times { code_bytes.rewind; BSON::Code.from_bson(code_bytes) }
  end

  false_bytes = StringIO.new
  false.to_bson(false_bytes)
  bench.report("Bool#from_bson ----->") do
    count.times { false_bytes.rewind; Bool.from_bson(false_bytes) }
  end

  max_key_bytes = StringIO.new
  BSON::MaxKey.new.to_bson(max_key_bytes)
  bench.report("MaxKey#from_bson ------>") do
    count.times { max_key_bytes.rewind; BSON::MaxKey.from_bson(max_key_bytes) }
  end

  min_key_bytes = StringIO.new
  BSON::MinKey.new.to_bson(min_key_bytes)
  bench.report("MinKey#from_bson ------>") do
    count.times { min_key_bytes.rewind; BSON::MinKey.from_bson(min_key_bytes) }
  end

  object_id_bytes = StringIO.new
  BSON::ObjectId.new.to_bson(object_id_bytes)
  bench.report("ObjectId#from_bson ---->") do
    count.times { object_id_bytes.rewind; BSON::ObjectId.from_bson(object_id_bytes) }
  end

  regex_bytes = StringIO.new
  %r{\d+}.to_bson(regex_bytes)
  bench.report("Regex#from_bson ------>") do
    count.times { regex_bytes.rewind; Regex.from_bson(regex_bytes) }
  end

  string_bytes = StringIO.new
  "testing".to_bson(string_bytes)
  bench.report("String#from_bson ------>") do
    count.times { string_bytes.rewind; String.from_bson(string_bytes) }
  end

  symbol_bytes = StringIO.new
  "testing".to_bson(symbol_bytes)
  bench.report("Symbol#from_bson ------>") do
    count.times { symbol_bytes.rewind; BSON::Symbol.from_bson(symbol_bytes) }
  end

  time_bytes = StringIO.new
  Time.new.to_bson(time_bytes)
  bench.report("Time#from_bson -------->") do
    count.times { time_bytes.rewind; Time.from_bson(time_bytes) }
  end

  doc_bytes = StringIO.new
  document.to_bson(doc_bytes)
  bench.report("Document#from_bson ---->") do
    count.times { doc_bytes.rewind; BSON::Document.from_bson(doc_bytes) }
  end
end