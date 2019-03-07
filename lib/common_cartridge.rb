require 'sax-machine'

module CommonCartridge
  def self.parse_from_zip(zipfile)
    parser = Parsers::Parser.new(zipfile)
    package = parser.parse
    package
  end

  # todo: methods to detect version and inject resultant namespace

  # Configuration
  class << self
    attr_accessor :config
  end

  def self.configure
    self.config ||= Config.new
    yield(config)
  end

  class Config
    attr_accessor :import_directory, :export_directory

    def initialize
      @import_directory = '.'
      @export_directory = '/tmp'
    end
  end
end

require 'common_cartridge/elements/lom'
require 'common_cartridge/elements/metadata'
require 'common_cartridge/elements/organizations'
require 'common_cartridge/elements/resources'
require 'common_cartridge/elements/outcomes'
require 'common_cartridge/elements/manifest'
require 'common_cartridge/package'
require 'common_cartridge/parsers/parser'
require 'common_cartridge/version'
