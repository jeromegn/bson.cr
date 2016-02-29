struct Symbol
  include BSON::Value

  def to_bson(bson : IO)
    to_s.to_bson(bson)
  end

  def self.from_bson(bson : IO)
    BSON::Symbol.from_bson(bson)
  end

end