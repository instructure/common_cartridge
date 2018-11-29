module CommonCartridge
  module Elements
    class Manifest
      include SAXMachine

      element :metadata, class: CommonCartridge::Elements::Metadata
      element :organizations, class: CommonCartridge::Elements::Organizations::RootOrganization, as: :root_organization
      element :resources, class: CommonCartridge::Elements::Resources::RootResource, as: :root_resource
      attribute :identifier, required: true
      attribute :xmlns
      attribute 'xmlns:lomimscc', as: :xmlns_lomimscc
      attribute 'xmlns:lom', as: :xmlns_lom
      attribute 'xmlns:xsi', as: :xmlns_xsi
      attribute 'xsi:schemaLocation', as: :xsi_schema_location

      def organizations
        root_organization.organizations
      end

      def resources
        root_resource.resources
      end

      def organization
        organizations.first
      end

    end
  end
end
