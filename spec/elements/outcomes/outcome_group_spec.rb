require 'spec_helper'

module CommonCartridge
  module Elements
    module Outcomes
      describe OutcomeGroup do
        before(:all) do
          @package = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc')
        end

        let(:outcome_groups) { @package.outcomes.outcome_groups }
        let(:outcome_group) { outcome_groups.first }

        it "is parsed correctly" do
          expect(outcome_groups.size).to eq(1)
        end

        it "has an identifier attribute" do
          expect(outcome_group.identifier).to eq("i5c10922a7fdce7cb710733108d3a26dc")
        end

        it "has a collection of outcomes" do
          expect(outcome_group.outcomes.size).to eq(9)
        end
      end
    end
  end
end

