require 'awspec/type/rds/base'
require 'awspec/type/ec2/security_group'

module Awspec
  module Type
    module RDS
      class Instance < Base
   
        def initialize(name)
          super

          @instance = {}
          res = @rds.client.describe_db_instances(:db_instance_identifier => name)
          @instance = res[:db_instances].first
        end

        def method_missing(name)
          key = name.to_s
          if @instance.has_key?(key) && !@instance[key].is_a?(Array) && !@instance[key].is_a?(Hash) then
            @instance[key]
          else
            super
          end
        end

        def endpoint
          "#{@instance[:endpoint][:address]}:#{@instance[:endpoint][:port]}"
        end

        def endpoint_address
          @instance[:endpoint][:address]
        end

        def endpoint_port
          @instance[:endpoint][:port]
        end

        def db_security_group(name)
          @instance[:db_security_groups].each do |sg|
            if sg[:db_security_group_name] == name then
              return sg
            end
          end
          raise NameError, "DB Security Group [#{name}] is not exists or not attached."
        end

        def vpc_security_group(name)
          sg = Awspec::Type::EC2::SecurityGroup.new(name)
          @instance[:vpc_security_groups].each do |group|
            if group[:vpc_security_group_id] == sg.id then
              return group
            end
          end
          raise NameError, "VPC Security Group [#{name}] is not exists or not attached."
        end

      end
    end
  end
end