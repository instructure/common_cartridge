module CommonCartridge
  module Elements
    module Resources
      class Assessment
        attr_accessor :title, :identifier

        include SAXMachine

        element :points_possible

        def self.type
          :quiz
        end

        def self.pattern
          /assessment|quiz/
        end
      end
    end
  end
end
