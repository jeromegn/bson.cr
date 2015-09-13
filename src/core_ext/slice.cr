struct Slice(T)
  
  def to_i32
    b1, b2, b3, b4 = self
    tuples32 = {b1, b2, b3, b4}
    (pointerof(tuples32) as Int32*).value
  end

  def to_i64
    b1, b2, b3, b4, b5, b6, b7, b8 = self
    tuples64 = {b1, b2, b3, b4, b5, b6, b7, b8}
    (pointerof(tuples64) as Int64*).value
  end

  def to_f64
    b1, b2, b3, b4, b5, b6, b7, b8 = self
    tuples64 = {b1, b2, b3, b4, b5, b6, b7, b8}
    (pointerof(tuples64) as Float64*).value
  end

end