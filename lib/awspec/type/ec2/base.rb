require 'awspec/type/base'

module Awspec
  module Type
    module EC2
      class Base < Awspec::Type::Base

        def initialize(name)
          super
          @ec2 = AWS::EC2::new
        end

      end
    end
  end
end