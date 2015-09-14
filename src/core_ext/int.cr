abstract struct Int

  def to_bson(bson : IO)
    bson.write(to_bytes)
  end

end