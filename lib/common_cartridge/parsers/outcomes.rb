module CommonCartridge
  module Parsers
    class Outcomes
      def initialize(zipfile)
        @zipfile = zipfile
      end

      def parse!
        Parser.use_file(@zipfile, 'course_settings/learning_outcomes.xml') do |xml|
          return CommonCartridge::Elements::Outcomes::OutcomeRoot.parse(xml)
        end
      end
    end
  end
end


