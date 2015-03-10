require 'spec_helper'

module CommonCartridge
  module Elements
    module Outcomes
      describe Outcome do
        before(:all) do
          @package = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc')
        end

        let(:outcomes) { @package.all_outcomes }
        let(:outcome) { @package.all_outcomes.first }

        it "is parsed correctly" do
          expect(outcomes.size).to eq(9)
        end

        it "has an identifier attribute" do
          expect(outcome.identifier).to eq "i63a00efe444e7edfc75e3051a4f8edac"
        end

        it "has a title element" do
          expect(outcome.title).to match(/You can speak the 'HigherEd-K12-Education' speak/)
        end

        it "has a points_possible element" do
          expect(outcome.points_possible).to eq "5"
        end

        it "has a mastery_points element" do
          expect(outcome.mastery_points).to eq "3"
        end
      end
    end
  end
end

