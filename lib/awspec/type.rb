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
        self.class.const_get('Awspec').const_get('Type').const_get(convert_name(class_names.first)).const_get(convert_name(class_names.last)).new(name)
      end
    end

    def convert_name(name)
      services = {
        "ec2" => "EC2",
        "rds" => "RDS",
      }
      
      if services.has_key?(name) then
        services[name]
      else
        name.capitalize
      end
    end

  end
end