require 'spec_helper'

module CommonCartridge
  module Elements
    module Lom
      describe General do
        before(:all) do
          manifest = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc').manifest
          @lom = manifest.metadata.lom
        end

        subject(:general) { @lom.general }

        it "parses correctly" do
          expect(general).to be_kind_of(CommonCartridge::Elements::Lom::General)
        end

        context "title element" do
          it "parses correctly" do
            expect(general.title).to be_kind_of(CommonCartridge::Elements::Lom::Title)
          end

          it "has a value attribute" do
            expect(general.title.value).to eq("Common Cartridge Test Data Set - Validation Cartridge 1")
          end

          it "has a language attribute" do
            expect(general.title.language).to eq("en-US")
          end
        end

        context "description element" do
          it "parses correctly" do
            expect(general.description).to be_kind_of(CommonCartridge::Elements::Lom::Description)
          end

          it "has a value attribute" do
            expect(general.description.value).to eq("Sample materials to test a variety of Common Cartridge content types")
          end

          it "has a language attribute" do
            expect(general.description.language).to eq("en-US")
          end
        end

        context "keywords elements" do
          it "is a collection" do
            expect(general.keywords).to be_kind_of(Array)
          end

          it "parses correctly" do
            expect(general.keywords.first).to be_kind_of(CommonCartridge::Elements::Lom::Keyword)
          end

          it "has a value attribute" do
            expect(general.keywords.first.value).to eq("Sample")
          end

          it "has a language attribute" do
            expect(general.keywords.first.language).to eq("en-US")
          end
        end
      end
    end
  end
end
