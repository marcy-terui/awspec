$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'coveralls'
Coveralls.wear!

%w(AWS AMAZON).each do |prefix|
  ENV.delete("#{prefix}_REGION")
  ENV.delete("#{prefix}_ACCESS_KEY_ID")
  ENV.delete("#{prefix}_SECRET_ACCESS_KEY")
end

require 'awspec'
require 'rspec/mocks/standalone'

AWS.config(
  :access_key_id => "dummy",
  :secret_access_key => "dummy",
)

AWS::stub!

include Awspec::Type::Helper
