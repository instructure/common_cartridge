require 'spec_helper'

module CommonCartridge
  module Elements
    describe Organizations do
      before(:all) do
        @manifest = CommonCartridge.parse_from_zip("canvas_large_1.3.imscc").manifest
      end

      let(:organizations) { @manifest.organizations }

      it "has a root organization" do
        expect(@manifest.root_organization).to be_kind_of(CommonCartridge::Elements::Organizations::RootOrganization)
      end

      it "has a root item" do
        expect(organizations.first.root_item).to be_kind_of(CommonCartridge::Elements::Organizations::RootItem)
      end

      describe Organizations::RootItem do
        let(:root_item) { organizations.first.root_item }

        it "has an identifier" do
          expect(root_item.identifier).to eq("LearningModules")
        end

        it "has a collection of items" do
          expect(root_item.items).to be_kind_of(Array)

          root_item.items.each do |item|
            expect(item).to be_kind_of(CommonCartridge::Elements::Organizations::Item)
          end
        end
      end

      describe Organizations::Item do
        # todo: use find_by method here when implemented
        let(:item) { organizations.first.root_item.items.first }

        it "has an identifier" do
          expect(item.identifier).to eq("i224aa0e52b019dbf9aeece014df883c7")
        end

        it "has a title" do
          expect(item.title).to eq("Example Course Module")
        end
      end
    end
  end
end

