require 'awspec/type/base'
require 'awspec/type/ec2/base'

module Awspec
  module Type
    module EC2
      class SecurityGroup < Base

        def initialize(name)
          super
          res = @ec2.client.describe_security_groups(:group_names => [name])
          if res[:security_group_info].length > 1 then
            raise RuntimeError, "Security Group [#{name}] is not Unique."
          end
          @sg = res[:security_group_info].first
        end

        def id
          @sg[:group_id]
        end

      end
    end
  end
end