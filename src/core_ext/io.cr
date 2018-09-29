class IO
  def next_bytes(n : Int32)
    bytes = Slice(UInt8).new(n)
    read(bytes)
    bytes
  end

  def write_byte(n : Int32)
    write_byte(n.to_u8)
  end
end
