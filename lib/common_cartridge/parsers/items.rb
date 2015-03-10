module CommonCartridge
  module Parsers
    class Items
      def initialize(zipfile, mod, resources)
        @zipfile = zipfile
        @mod = mod
        @resources = resources
      end

      def parse!
        @mod.items.each do |item|
          map_item_to_type(item)
          unless item.items.empty?
            item.items.each { |i| map_item_to_type(i) }
          end
        end
      end

      private
      def map_item_to_type(item)
        if resource = find_resource_by_ref(item.identifierref)
          if types = Elements::Resources.type_mappings.detect { |pattern, type| resource.type =~ pattern }
            item.type = types.last.type
          else !resource.type.empty?
            item.type = resource.type
          end

          if item.type == :page && resource.href =~ /web_resources/
            item.type = 'file'
          end
        end

        if item.type.nil? || item.type.empty?
          Parser.use_file(@zipfile, 'course_settings/module_meta.xml') do |xml|
            doc = Nokogiri::XML(xml)
            doc.remove_namespaces!
            item.type = snake_case(doc.xpath("//item[@identifier = '#{item.identifier}' or @identifier='#{item.identifierref}']/content_type").text)

          end
        end
      end

      def find_resource_by_ref(ref)
        @resources.detect do |resource|
          resource.identifier == ref
        end
      end

      def snake_case(text)
        text.gsub(/::/, '/').
          gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
          gsub(/([a-z\d])([A-Z])/,'\1_\2').
          tr("-", "_").
          downcase
      end
    end
  end
end
