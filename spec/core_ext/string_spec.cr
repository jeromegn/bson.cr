require "../spec_helper"

describe String do
  
  describe "#to_bson" do
    
    it "blah" do

      str = StringIO.new("")
      puts "hello".to_bson(str)
      puts str.inspect

      str.rewind
      puts String.from_bson(str)

    end

  end

end