require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe Topic do
        before(:all) do
          manifest = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc').manifest
          @resource = manifest.resources.detect { |r| r.identifier =~ /I_00006_R/ } 
        end

        it "is parsed correctly" do
          expect(@resource.files.first.content).to be_kind_of(CommonCartridge::Elements::Resources::Topic)
        end

        it "has a title" do
          expect(@resource.files.first.content.title).to eq("The Psychology of Faces")
        end

        it "has text" do
          expect(@resource.files.first.content.text).to match(/Your face is ugly\./)
        end

        it "has a text_type" do
          expect(@resource.files.first.content.text_type).to eq("text/html")
        end

        it "has attachments" do
          expect(@resource.files.first.content.attachments).not_to be_empty

          @resource.files.first.content.attachments.each do |a|
            expect(a.href).not_to be_empty
          end
        end
      end
    end
  end
end

