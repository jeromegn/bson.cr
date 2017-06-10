require "./specialized"

module BSON
  struct MinKey
    include Specialized
    extend Specialized::ClassMethods
  end
end
