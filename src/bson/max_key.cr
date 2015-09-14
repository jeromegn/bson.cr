require "./specialized"

module BSON
  struct MaxKey
    include Specialized
    extend Specialized::ClassMethods    
  end
end