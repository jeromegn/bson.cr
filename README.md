# BSON

BSON implemented in Crystal according to the [spec](http://bsonspec.org/spec.html).

## Installation

Add this line to your application's `shard.yml`:

```yml
dependencies:
  bson:
    github: jeromegn/bson.cr
```

## Usage

```crystal
require "bson"

io = File.open(File.expand_path("examples/sample.bson")) # A pretty representative BSON document
BSON.decode(io) # => Returns a Hash instance

bson, writer = IO.pipe
"a string".to_bson(writer) # => encodes the string to BSON and writes to the IO

puts String.from_bson(bson).inspect # => "a string"

doc = Hash{
  "name" => "hello",
  "int" => 32
}

puts doc # => { "name" => "hello", "int" => 32 }

bson, writer = IO.pipe
doc.to_bson(writer) # => Encodes the whole document to BSON and writes to the IO

puts BSON.decode(bson) # => { "name" => "hello", "int" => 32 }
```

## Supported types

All types specified in the [BSON spec](http://bsonspec.org/spec.html).

Relevant basic types of Crystal have been extended to add `#to_bson(io : IO)` and `.from_bson(io : IO)` for simplicity.

A `BSON::Document` is just an alias for `Hash(String, BSON::Type)`

## TODOs

- [ ] More tests

## Caveats

- Only supported Regex options are the ones also supported by Crystal: `i` and `m` basically.

## Contributing

1. Fork it ( https://github.com/jeromegn/bson.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jeromegn](https://github.com/jeromegn) Jerome Gravel-Niquet - creator, maintainer
