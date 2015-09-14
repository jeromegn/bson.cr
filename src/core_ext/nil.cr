struct Nil

  def self.from_bson(bson : IO)
    nil
  end

  def to_bson(bson : IO)
    # Do nothing
  end

  def bson_size
    0
  end

end