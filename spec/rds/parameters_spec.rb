require 'spec_helper'

module Awspec
  module Type
    module RDS
      class Base < Awspec::Type::Base

        def initialize(name)
          super
          @rds = AWS::RDS::new
          res = @rds.client.stub_for(:describe_db_parameters)
          res.data[:parameters] = [
            { :parameter_name => "key1", :parameter_value => "value1" },
            { :parameter_name => "key2", :parameter_value => "value2" },
            { :parameter_name => "key3", :parameter_value => "value3" },
          ]
        end

      end
    end
  end
end

describe rds_parameters('test') do
  its(:key1)  { should eq("value1") }
  its("key2") { should eq("value2") }
  its(:key3)  { is_expected.to eq("value3") }
end

