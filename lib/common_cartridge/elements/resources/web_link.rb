module CommonCartridge
  module Elements
    module Resources
      class WebLink
        attr_accessor :identifier

        include SAXMachine

        element :title
        element :url
        element :url, value: :href, as: :href
        element :url, value: :target, as: :target
        element :url, value: :windoFeatures, as: :window_features

        def self.type
          :weblink
        end

        def self.pattern
          /wl/
        end
      end
    end
  end
end
