module CommonCartridge
  module Elements
    module Resources
      class Page
        attr_accessor :identifier, :identifierref

        include SAXMachine
        element :title
        element :text
        element :text, value: :texttype, as: :text_type

        def self.type
          :page
        end

        def self.pattern
          /webcontent/
        end
      end
    end
  end
end
