module CommonCartridge
  module Elements
    module Outcomes
      class OutcomeRoot
        include SAXMachine

        elements 'learningOutcomeGroup', as: :outcome_groups, class: OutcomeGroup
      end
    end
  end
end
