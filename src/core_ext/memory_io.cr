class MemoryIO

  # allow writing an array to this IO
  def write(ary : Array(UInt8))
    write(ary.as_slice)
  end

end