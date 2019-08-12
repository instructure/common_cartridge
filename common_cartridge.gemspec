# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'common_cartridge/version'

Gem::Specification.new do |spec|
  spec.name          = 'common_cartridge'
  spec.version       = CommonCartridge::VERSION
  spec.authors       = ['Josh Simpson', 'Remy Obein']
  spec.email         = ['jsimpson@instructure.com', 'remy@cassia.tech']
  spec.summary       = %q{CommonCartridge}
  spec.description   = 'Parse IMS Common Cartridge packages'
  spec.homepage      = 'http://www.instructure.com/'
  spec.license       = 'MIT'

  spec.files         = Dir.glob("{lib,spec}/**/*")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'sax-machine', '~> 1.3.2'
  spec.add_dependency 'nokogiri', '~> 1.8.1'
  spec.add_dependency 'rubyzip', '~> 1.2.1'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
