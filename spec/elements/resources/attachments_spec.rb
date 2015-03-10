require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe Attachments do
        before(:all) do
          manifest = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc').manifest
          resource = manifest.resources.detect { |r| r.identifier =~ /I_00006_R/ }
          @attachment = resource.files.first.content.attachments.first
        end

        it "is parsed correctly" do
          expect(@attachment).to be_kind_of(CommonCartridge::Elements::Resources::Attachments::Attachment)
        end

        it "has a href" do
          expect(@attachment.href).to match(/angry_person\.jpg/)
        end
      end
    end
  end
end

