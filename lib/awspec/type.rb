module Awspec
  module Type
    types = [
      "rds/parameters",
    ]
    
    types.each do |type|
      require "awspec/type/#{type}"
      method_name  = type.gsub("/","_")
      class_names  = type.split("/")
      define_method method_name do |*args|
        name = args.first
        self.class.const_get('Awspec').const_get('Type').const_get(class_names.first.capitalize).const_get(class_names.last.capitalize).new(name)
      end
    end

  end
end