require 'zip'

require 'common_cartridge/parsers/dependencies'
require 'common_cartridge/parsers/files'
require 'common_cartridge/parsers/outcomes'
require 'common_cartridge/parsers/questions'
require 'common_cartridge/parsers/items'

module CommonCartridge
  module Parsers
    class Parser
      def self.use_file(zipfile, path)
        Zip::File.open(File.join(CommonCartridge.config.import_directory, zipfile)) do |file|
          f = file.glob(path).first
          unless f.nil?
            yield f.get_input_stream.read
          end
        end
      end

      def initialize(zipfile)
        @zipfile = zipfile
        @package = Package.new
      end

      def parse
        Parser.use_file(@zipfile, 'imsmanifest.xml') do |xml|
          @package.manifest = CommonCartridge::Elements::Manifest.parse(xml)
        end

        parse_content!
        @package.outcomes = parse_outcomes
        parse_questions!
        parse_module_items!
        @package
      end

      private
      def parse_module_items!
        @package.modules.each do |mod|
          item_parser = Parsers::Items.new(@zipfile, mod, @package.manifest.resources)
          item_parser.parse!
        end
      end

      def parse_outcomes
        outcomes_parser = Parsers::Outcomes.new(@zipfile)
        outcomes_parser.parse!
      end

      def parse_content!
        @package.manifest.resources.map do |resource|
          parse_resource! resource
        end
      end

      def parse_resource! resource
        file_parser = Parsers::Files.new(@zipfile, resource)
        file_parser.parse!(@package)
        dependency_parser = Parsers::Dependencies.new(@zipfile, resource)
        dependency_parser.parse!(@package)
      rescue RuntimeError => e
        Rails.logger.error "CommonCartridge parse error: #{e.to_s}"
        Rails.logger.error e.backtrace
      end

      def parse_questions!
        @package.quizzes.each do |quiz|
          parser = Parsers::Questions.new(@zipfile, quiz)
          parser.parse!
        end
      end

    end
  end
end


