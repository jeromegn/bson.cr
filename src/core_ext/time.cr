struct Time

  def self.from_bson(bson : IO)
    epoch_ms Int64.from_bson(bson)
  end

end