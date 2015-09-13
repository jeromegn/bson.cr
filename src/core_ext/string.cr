class String

  def self.from_bson(bson : IO)
    size = bson.next_bytes(4).to_i32
    puts "string size: #{size} bytes"

    String.build do |str|
      bson.next_bytes(size).to_a[0..-2].each do |byte|
        str << byte.chr
      end
      str
    end
  end

end