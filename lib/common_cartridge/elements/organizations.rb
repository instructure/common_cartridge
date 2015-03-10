module CommonCartridge
  module Elements
    module Organizations
      class Item
        attr_accessor :type

        include SAXMachine

        attribute :identifier
        attribute :identifierref
        element :title

        elements :item, class: self, as: :items
      end

      class RootItem
        include SAXMachine

        attribute :identifier
        attribute :identifierref

        elements :item, class: Item, as: :items

        # todo: implement 'find_by' method here to quickly scan for particular items
      end

      class Organization
        include SAXMachine

        attribute :identifier
        attribute :structure
        element :item, class: RootItem, as: :root_item
      end

      class RootOrganization
        include SAXMachine

        elements :organization, class: Organization, as: :organizations
      end
    end
  end
end
