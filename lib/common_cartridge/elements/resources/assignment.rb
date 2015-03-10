module CommonCartridge
  module Elements
    module Resources
      class Format
        include SAXMachine

        attribute :type
      end

      class SubmissionFormats
        include SAXMachine

        elements :format, class: Format, as: :formats
      end

      class Text
        include SAXMachine

        attribute :href
        attribute :texttype, as: :text_type
        value :value
      end

      class InstructorText
        include SAXMachine

        attribute :href
        attribute :texttype, as: :text_type
        value :value
      end

      class Assignment
        attr_accessor :identifier, :points_possible

        include SAXMachine

        element :title
        element :text, class: Text
        element :instructor_text, class: InstructorText
        element :gradable

        element :submission_formats, class: SubmissionFormats
        element :attachments, class: CommonCartridge::Elements::Resources::Attachments::RootAttachment, as: :attachment_root

        def attachments
          attachment_root.attachments
        end

        def self.type
          :assignment
        end

        def self.pattern
          /assignment|associatedcontent\/imscc_xmlv1p1\/learning\-application\-resource/
        end
      end
    end
  end
end
