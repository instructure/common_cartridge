module CommonCartridge
  module Elements
    class Manifest
      include SAXMachine

      element :metadata, class: CommonCartridge::Elements::Metadata
      element :organizations, class: CommonCartridge::Elements::Organizations::RootOrganization, as: :root_organization
      element :resources, class: CommonCartridge::Elements::Resources::RootResource, as: :root_resource

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
