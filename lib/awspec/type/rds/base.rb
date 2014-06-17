require 'awspec/type/base'

module Awspec
  module Type
    module RDS
      class Base < Awspec::Type::Base

        def initialize(name)
          super
          @rds = AWS::RDS::new
        end

      end
    end
  end
end