require 'spec_helper'

module CommonCartridge
  describe Parsers::Parser do
    describe ".parse_from_zip" do
      it "parses a Common CommonCartridge zip successfully" do
        package = CommonCartridge.parse_from_zip("canvas_small_1.1.imscc")
        expect(package).to be_kind_of(CommonCartridge::Package)
        expect(package.manifest).to be_kind_of(CommonCartridge::Elements::Manifest)
      end
    end
  end
end
