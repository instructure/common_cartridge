module CommonCartridge
  module Parsers
    class Dependencies
      attr_reader :resource

      def initialize(zipfile, resource)
        @zipfile = zipfile
        @resource = resource
      end

      def parse!(package)
        resource.dependencies.each do |d|
          resource = package.find_resource(d.identifierref)
          resource.files.each do |f|
            Parser.use_file(@zipfile, f.href) do |xml|
              d.contents << CommonCartridge::Elements::Resources::Content.parse(xml)
            end
          end
        end
      end
    end
  end
end
