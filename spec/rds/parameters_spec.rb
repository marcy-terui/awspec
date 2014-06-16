require 'spec_helper'

module Awspec
  module Type
    module Rds
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

describe Awspec::Type::Rds::Parameters do
  rds = Awspec::Type::Rds::Parameters.new('test')
  example { expect(rds.key1).to eq('value1') }
  example { expect(rds.key2).to eq('value2') }
  example { expect(rds.key3).to eq('value3') }
end

