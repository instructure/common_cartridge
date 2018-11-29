module CommonCartridge
  module Elements
    module Resources
      class BasicLTILink
        attr_accessor :identifier

        include SAXMachine

        attribute :xmlns
        attribute 'xmlns:blti', as: :xmlns_blti
        attribute 'xmlns:lticm', as: :xmlns_lticm
        attribute 'xmlns:lticp', as: :xmlns_lticp
        attribute 'xmlns:xsi', as: :xmlns_xsi
        attribute 'xsi:schemaLocation', as: :xsi_schema_location

        element :title
        element :description
        element :secure_launch_url
        element :code, :as => :vendor_code
        element :name, :as => :vendor_name
        element :url, :as => :vendor_url
        element :email, :as => :vendor_contact_email

        def self.type
          :basic_lti_link
        end

        def self.pattern
          /imsbasiclti_xmlv1p0/
        end
      end
    end
  end
end
