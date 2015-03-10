module CommonCartridge
  module Parsers
    class Questions
      def initialize(zipfile, quiz)
        @zipfile = zipfile
        @quiz = quiz
      end

      def parse!
        @quiz.file_locations.each do |location|
          Parser.use_file(@zipfile, location) do |xml|
            doc = Nokogiri::XML(xml)
            doc.remove_namespaces!
            unless @quiz.question_count && !canvas?(location)
              # We need all questions that aren't a text only question. Re-usable, important sibling XML elements *sigh*.
              @quiz.question_count = doc.xpath("//item//fieldlabel[text()='question_type' or text()='cc_profile']/following-sibling::fieldentry[1][text() != 'text_only_question']").length
            end

            unless @quiz.points_possible
              if points = doc.xpath("//fieldlabel[text()='points_possible']/following-sibling::fieldentry[1]")
                @quiz.points_possible = points.text
              end
            end
          end
        end
      end

      private
      def canvas?(location)
        location =~ /non_cc_assessments/
      end
    end
  end
end
