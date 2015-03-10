module CommonCartridge
  module Elements
    module Outcomes
      class Outcome
        include SAXMachine

        attribute :identifier

        element :title
        element :points_possible
        element :mastery_points
      end
    end
  end
end
