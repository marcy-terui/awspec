module Awspec
  module Type
    class RdsBase < Base
 
      def initialize(name)
        super
        @rds = AWS::RDS::new
      end
  end
end