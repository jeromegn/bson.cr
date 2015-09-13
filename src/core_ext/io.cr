module IO

  def next_bytes(n : Int32)
    bytes = Slice(UInt8).new(n)
    read(bytes)
    bytes
  end

end