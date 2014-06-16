require 'awspec/type/rds/base'

module Awspec
  module Type
    module Rds
      class Parameters < Base

        MAX_RECORDS = 100
   
        def initialize(name)
          super

          @parameters = {}
          marker = ""
          while (@parameters.length == 0) || (@parameters.length % MAX_RECORDS == 0) do
            if marker.empty? then
              res = @rds.client.describe_db_parameters(
                :db_parameter_group_name  => name,
                :max_records => MAX_RECORDS)
            else
              res = @rds.client.describe_db_parameters(
                :db_parameter_group_name  => name,
                :max_records => MAX_RECORDS,
                :marker => marker)
            end
            marker = res[:marker]
            if res[:parameters].empty? then
              break
            end
            res[:parameters].each do |param|
              @parameters[param[:parameter_name]] = param[:parameter_value]
            end
          end
        end
   
        def method_missing(name)
          param_name = name.to_s
          if @parameters.has_key?(param_name) then
            @parameters[param_name].to_s
          else
            super
          end
        end

      end
    end
  end
end