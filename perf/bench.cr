require "../src/bson"
require "benchmark"

Benchmark.bm do |bench|

  count = 1_000_000

  document = Hash(String, BSON::Type){"field1": "test", "field2": "hello"}
  embedded = [] of BSON::Type

  5.times {
    embedded << Hash(String, BSON::Type){"field1": 10, "field2": "test"} }
  document["embedded"] = embedded

  bench.report("Hash#to_bson -------->") do
    count.times { document.to_bson }
  end

  bench.report("Binary#to_bson ---------->") do
    count.times { BSON::Binary.new("test".to_slice, :generic).to_bson }
  end

  bench.report("Code#to_bson ------------>") do
    count.times { BSON::Code.new("this.value = 1").to_bson }
  end

  bench.report("Bool(false)#to_bson ----->") do
    count.times { false.to_bson }
  end

  bench.report("Bool(true)#to_bson ------>") do
    count.times { true.to_bson }
  end

  bench.report("Float64#to_bson --------->") do
    count.times { 1.131312.to_bson }
  end

  bench.report("Int32#to_bson ----------->") do
    count.times { 1024.to_bson }
  end

  bench.report("Int64#to_bson ----------->") do
    count.times { (Int32::MAX + 1).to_bson }
  end

  bench.report("MaxKey#to_bson ---------->") do
    count.times { BSON::MaxKey.new.to_bson }
  end

  bench.report("MinKey#to_bson ---------->") do
    count.times { BSON::MinKey.new.to_bson }
  end

  bench.report("ObjectId#to_bson -------->") do
    count.times { BSON::ObjectId.new.to_bson }
  end

  bench.report("ObjectId#to_s ----------->") do
    object_id = BSON::ObjectId.new
    count.times { object_id.to_s }
  end

  bench.report("Regex#to_bson ----------->") do
    count.times { %r{\d+}.to_bson }
  end

  bench.report("String#to_bson ---------->") do
    count.times { "testing".to_bson }
  end

  bench.report("Symbol#to_bson ---------->") do
    count.times { :testing.to_bson }
  end

  bench.report("Time#to_bson ------------>") do
    count.times { Time.new.to_bson }
  end

  bool_bytes = true.to_bson
  bench.report("Bool(true)#from_bson ---->") do
    count.times { Bool.from_bson(bool_bytes.rewind) }
  end

  false_bytes = false.to_bson
  bench.report("Bool(false)#from_bson --->") do
    count.times { Bool.from_bson(false_bytes.rewind) }
  end

  int32_bytes = 1024.to_bson
  bench.report("Int32#from_bson --------->") do
    count.times { Int32.from_bson(int32_bytes.rewind) }
  end

  int64_bytes = (Int32::MAX + 1).to_i64.to_bson
  bench.report("Int64#from_bson --------->") do
    count.times { Int64.from_bson(int64_bytes.rewind) }
  end

  float64_bytes = Float64::MIN.to_bson
  bench.report("Float64#from_bson ------->") do
    count.times { Float64.from_bson(float64_bytes.rewind) }
  end

  binary_bytes = BSON::Binary.new("test".to_slice).to_bson
  bench.report("Binary#from_bson -------->") do
    count.times { BSON::Binary.from_bson(binary_bytes.rewind) }
  end

  code_bytes = BSON::Code.new("this.value = 1").to_bson
  bench.report("Code#from_bson ---------->") do
    count.times { BSON::Code.from_bson(code_bytes.rewind) }
  end

  max_key_bytes = BSON::MaxKey.new.to_bson
  bench.report("MaxKey#from_bson -------->") do
    count.times { BSON::MaxKey.from_bson(max_key_bytes.rewind) }
  end

  min_key_bytes = BSON::MinKey.new.to_bson
  bench.report("MinKey#from_bson -------->") do
    count.times { BSON::MinKey.from_bson(min_key_bytes.rewind) }
  end

  object_id_bytes = BSON::ObjectId.new.to_bson
  bench.report("ObjectId#from_bson ------>") do
    count.times { BSON::ObjectId.from_bson(object_id_bytes.rewind) }
  end

  regex_bytes = %r{\d+}.to_bson
  bench.report("Regex#from_bson --------->") do
    count.times { Regex.from_bson(regex_bytes.rewind) }
  end

  string_bytes = "testing".to_bson
  bench.report("String#from_bson -------->") do
    count.times { String.from_bson(string_bytes.rewind) }
  end

  symbol_bytes = :testing.to_bson
  bench.report("Symbol#from_bson -------->") do
    count.times { BSON::Symbol.from_bson(symbol_bytes.rewind) }
  end

  time_bytes = Time.new.to_bson
  bench.report("Time#from_bson ---------->") do
    count.times { Time.from_bson(time_bytes.rewind) }
  end

  doc_bytes = document.to_bson
  bench.report("Hash#from_bson ------>") do
    count.times { Hash.from_bson(doc_bytes.rewind) }
  end
end