module CommonCartridge
  module Elements
    module Resources
      module Attachments
        class Attachment
          include SAXMachine

          attribute :href
          attribute :role
        end

        class RootAttachment
          include SAXMachine

          elements :'dt:attachment', class: Attachment, as: :attachments
        end
      end
    end
  end
end
