module CommonCartridge
  module Parsers
    class Files
      attr_reader :resource

      def initialize(zipfile, resource)
        @zipfile = zipfile
        @resource = resource
      end

      def parse!(package)
        if mapping = resource_to_mapping(resource)
          resource.files.each do |f|
            Parser.use_file(@zipfile, f.href) do |xml|
              f.content = mapping.last.parse(xml)
              f.content.identifier = resource.identifier
              if resource.type =~ CommonCartridge::Elements::Resources::Assignment.pattern && f.href =~ /assignment.*xml/ && !(resource.href =~ /course/)
                doc = Nokogiri::XML(xml)
                doc.remove_namespaces!
                f.content.points_possible = doc.xpath('//points_possible').text
                package.assignments << f.content
              end
            end
          end
        end
      end

      private
      def resource_to_mapping(resource)
        CommonCartridge::Elements::Resources.type_mappings.detect { |regex, klass| resource.type =~ regex }
      end
    end
  end
end
