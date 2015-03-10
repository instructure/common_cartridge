# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "common cartridge"
  spec.version       = "1.0.0"
  spec.authors       = ["Josh Simpson"]
  spec.email         = ["jsimpson@instructure.com"]
  spec.summary       = %q{CommonCartridge}
  spec.description   = "Parse IMS Common Cartridge packages"
  spec.homepage      = "http://www.instructure.com/"
  spec.license       = "MIT"

  spec.files         = Dir.glob("{lib,spec}/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sax-machine", "~> 0.2.1"
  spec.add_dependency "rubyzip", "~> 1.1.6", ">= 1.1"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 3.0"
end
