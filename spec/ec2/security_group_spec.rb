require 'spec_helper'
require 'awspec/type/ec2/security_group'

module Awspec
  module Type
    module EC2
      class Base < Awspec::Type::Base

        def initialize(name)
          super
          @ec2 = AWS::EC2::new
          res = @ec2.client.stub_for(:describe_security_groups)
          res.data[:security_group_info] = [
            { :group_name => "sg_name", :group_id => "sg_id" },
          ]
        end

      end
    end
  end
end

describe Awspec::Type::EC2::SecurityGroup, "when length 1" do
  sg = Awspec::Type::EC2::SecurityGroup.new("sg_name")
  example { expect(sg.id).to eq "sg_id" }
end

module Awspec
  module Type
    module EC2
      class Base < Awspec::Type::Base

        def initialize(name)
          super
          @ec2 = AWS::EC2::new
          res = @ec2.client.stub_for(:describe_security_groups)
          res.data[:security_group_info] = [
            { :group_name => "sg_name", :group_id => "sg_id" },
            { :group_name => "sg_name", :group_id => "sg_id2" },
          ]
        end

      end
    end
  end
end

describe Awspec::Type::EC2::SecurityGroup, "when length 2" do
  example { expect{ Awspec::Type::EC2::SecurityGroup.new("sg_name") }.to raise_error(RuntimeError, "Security Group [sg_name] is not Unique.") }
end

