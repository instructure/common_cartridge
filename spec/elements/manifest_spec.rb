require 'spec_helper'

module CommonCartridge
  module Elements
    describe Manifest do
      before(:all) do
        @manifest = CommonCartridge.parse_from_zip("canvas_large_1.3.imscc").manifest
      end

      it "recognizes the manifest file and parses it correctly" do
        expect(@manifest).to be_kind_of(CommonCartridge::Elements::Manifest)
      end

      it "has metadata" do
        expect(@manifest.metadata).to be_kind_of(CommonCartridge::Elements::Metadata)
      end

      it "has organizations" do
        expect(@manifest.root_organization).to be_kind_of(CommonCartridge::Elements::Organizations::RootOrganization)
      end

      it "has resources" do
        expect(@manifest.root_resource).to be_kind_of(CommonCartridge::Elements::Resources::RootResource)
      end
    end
  end
end
