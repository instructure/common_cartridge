module CommonCartridge
  module Elements
    module Resources
      module BasicLtiLink
        class VendorContact
          include SAXMachine

          element 'lticp:email', as: :email
        end

        class Vendor
          include SAXMachine

          element 'lticp:code', as: :code
          element 'lticp:name', as: :name
          element 'lticp:description', as: :description
          element 'lticp:url', as: :url
          element 'lticp:contact', class: VendorContact, as: :contact
        end

        class ExtensionProperty
          include SAXMachine

          attribute :name
          value :value
        end

        class Extension
          include SAXMachine

          attribute :platform
          elements 'lticm:property', class: ExtensionProperty, as: :properties
        end

        class BasicLtiLink
          attr_accessor :identifier

          include SAXMachine

          attribute :xmlns
          attribute 'xmlns:blti', as: :xmlns_blti
          attribute 'xmlns:lticm', as: :xmlns_lticm
          attribute 'xmlns:lticp', as: :xmlns_lticp
          attribute 'xmlns:xsi', as: :xmlns_xsi
          attribute 'xsi:schemaLocation', as: :xsi_schema_location

          element 'blti:title', as: :title
          element 'blti:description', as: :description
          element 'blti:secure_launch_url', as: :secure_launch_url
          element 'blti:launch_url', as: :launch_url
          element 'blti:vendor', class: Vendor, as: :vendor

          elements 'blti:extensions', class: Extension, as: :extensions

          def self.type
            :basic_lti_link
          end

          def self.pattern
            /imsbasiclti_xmlv1p/
          end
        end
      end
    end
  end
end
