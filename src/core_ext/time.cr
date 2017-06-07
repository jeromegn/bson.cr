struct Time
  include BSON::Value

  def self.from_bson(bson : IO)
    epoch_ms Int64.from_bson(bson)
  end

  def to_bson(bson : IO)
    epoch_ms.to_bson(bson)
  end

  def bson_size
    sizeof(Int64)
  end
end
