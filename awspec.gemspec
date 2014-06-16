# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'awspec/version'

Gem::Specification.new do |spec|
  spec.name          = "awspec"
  spec.version       = Awspec::VERSION
  spec.authors       = ["Marcy"]
  spec.email         = ["marcy9114@gmail.com"]
  spec.summary       = %q{RSpec Test for your resources of Amazon Web Services.}
  spec.description   = %q{RSpec Test for your resources of Amazon Web Services.}
  spec.homepage      = ""
  spec.license       = "Apache 2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_dependency "aws-sdk"
  spec.add_dependency "rspec"
end
