require 'bundler/setup'
Bundler.setup

require 'common_cartridge'

CommonCartridge.configure do |c|
  c.import_directory = File.join(Dir.pwd, 'spec', 'files')
end

RSpec.configure do |config|
  config.order = :random
  Kernel.srand config.seed
end
