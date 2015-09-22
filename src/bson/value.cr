module BSON
  module Value

    def to_bson
      io = StringIO.new
      to_bson(io)
      io
    end

    def bson_size
      sizeof(typeof(self))
    end

  end
end