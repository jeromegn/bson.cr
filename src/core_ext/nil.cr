struct Nil
  include BSON::Specialized
  extend BSON::Specialized::ClassMethods

  def self.from_bson(bson : IO)
    nil
  end
end
