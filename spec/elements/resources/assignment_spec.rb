require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe Assignment do
        before(:all) do
          package = CommonCartridge.parse_from_zip('canvas_large_1.3.imscc')
          @assignment = package.assignments.first
        end

        it "parses correctly" do
          expect(@assignment).to be_kind_of(CommonCartridge::Elements::Resources::Assignment)
        end

        it "has a title" do
          expect(@assignment.title).to eq("Online Submission Assignment")
        end

        it "has a 'gradable' element" do
          expect(@assignment.gradable).to eq("true")
        end

        context "text element" do
          let(:text) { @assignment.text }

          it "parses correctly" do
            expect(text).to be_kind_of(CommonCartridge::Elements::Resources::Text)
          end

          it "has a value" do
            expect(text.value).to match(/Lorem ipsum dolor sit amet, consectetur adipiscing elit/)
          end
        end

        context "submission_formats" do
          let(:submission_formats) { @assignment.submission_formats }

          it "parses correctly" do
            expect(submission_formats).to be_kind_of(CommonCartridge::Elements::Resources::SubmissionFormats)
          end

          it "has formats" do
            expect(submission_formats.formats).to be_kind_of(Array)
            expect(submission_formats.formats).not_to be_empty
            expect(submission_formats.formats.first.type).to eq("html")
          end
        end
      end
    end
  end
end

