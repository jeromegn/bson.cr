require "../spec_helper"

describe BSON::ObjectId do

  describe ".new" do

    it "creates a standard-compliant ObjectId" do

      puts BSON::ObjectId.new.to_s
      puts BSON::ObjectId.new.generation_time.to_local

    end

  end

end