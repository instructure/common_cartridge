require 'spec_helper'

module CommonCartridge
  module Elements
    describe Metadata do
      context "Common Cartridge 1.1" do
        before(:all) { @metadata = CommonCartridge.parse_from_zip("canvas_small_1.1.imscc").manifest.metadata }

        it "has a schema" do
          expect(@metadata.schema).to eq("IMS Common Cartridge")
        end

        it "has a schemaversion" do
          expect(@metadata.schemaversion).to eq("1.1.0")
        end

        it "has a lom" do
          expect(@metadata.lom).to be_kind_of(CommonCartridge::Elements::Lom::Lom)
        end
      end

      context "Common Cartridge 1.3" do
        before(:all) { @metadata = CommonCartridge.parse_from_zip("canvas_large_1.3.imscc").manifest.metadata }

        it "has a schema" do
          expect(@metadata.schema).to eq("IMS Common Cartridge")
        end

        it "has a schemaversion" do
          expect(@metadata.schemaversion).to eq("1.3.0")
        end

        it "has a lom" do
          expect(@metadata.lom).to be_kind_of(CommonCartridge::Elements::Lom::Lom)
        end
      end
    end
  end
end

