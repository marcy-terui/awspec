module Awspec
  module Type
    class RdsParameters < RdsBase

      MAX_RECORDS = 100
 
      def initialize(name)
        super
        @group_name = name
        @parameters = {}

        marker = ""
        while (res.length == 0) || (@paramaters.length % MAX_RECORDS == 0) do
          if marker.empty? then
            res = @rds.client.describe_db_parameters(
              :db_parameter_group_name  => @group_name,
              :max_records => MAX_RECORDS)
          else
            res = @rds.client.describe_db_parameters(
              :db_parameter_group_name  => @group_name,
              :max_records => MAX_RECORDS,
              :marker => marker)
          end
          marker = res[:marker]
          res[:parameters].each do |param|
            @parameters[param[:parameter_name]] = param[:parameter_value]
          end
        end
      end
 
      def method_missing(name)
        if @parameters.has_key?(name) then
          @parameters[name].to_s
        else
          super
        end
      end
    end
 
    def rds_parameters(name)
      RdsParameters.new(name)
    end
  end
end