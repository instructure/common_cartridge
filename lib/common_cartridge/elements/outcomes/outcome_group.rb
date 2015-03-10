module CommonCartridge
  module Elements
    module Outcomes
      class OutcomeGroup
        include SAXMachine

        attribute :identifier
        elements 'learningOutcome', as: :outcomes, class: Outcome
      end
    end
  end
end
