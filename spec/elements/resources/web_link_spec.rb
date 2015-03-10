require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe WebLink do
        before(:all) do
          manifest = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc').manifest
          @resource = manifest.resources.detect { |r| r.identifier =~ /I_00005_R/ }
        end

        it "is parsed correctly" do
          expect(@resource.files.first.content).to be_kind_of(CommonCartridge::Elements::Resources::WebLink)
        end

        it "has a title" do
          expect(@resource.files.first.content.title).to eq("Wikipedia - Your Mom")
        end

        it "has a href" do
          expect(@resource.files.first.content.href).to eq("http://en.wikipedia.org/wiki/Maternal_insult")
        end

        it "has a target" do
          expect(@resource.files.first.content.target).to eq("_self")
        end
      end
    end
  end
end

