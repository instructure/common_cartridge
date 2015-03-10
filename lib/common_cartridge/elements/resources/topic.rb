module CommonCartridge
  module Elements
    module Resources
      class Topic
        attr_accessor :identifier

        include SAXMachine

        element :title
        element :text
        element :text, value: :texttype, as: :text_type
        element :attachments, class: Attachments::RootAttachment, as: :attachment_root

        def attachments
          attachment_root.attachments
        end

        def self.type
          :discussion
        end

        def self.pattern
          /imsdt/
        end
      end
    end
  end
end
