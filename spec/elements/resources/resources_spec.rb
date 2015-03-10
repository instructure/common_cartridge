require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe Resources do
        before(:all) do
          @package = CommonCartridge.parse_from_zip("canvas_small_1.1.imscc")
          @resources = @package.manifest.resources
        end

        it "has a root resource" do
          expect(@package.manifest.root_resource).to be_kind_of(CommonCartridge::Elements::Resources::RootResource)
        end

        it "has a collection of resources" do
          expect(@resources).to be_kind_of(Array)

          @resources.each do |resource|
            expect(resource).to be_kind_of(CommonCartridge::Elements::Resources::Resource)
          end
        end


        describe Resources::Resource do
          # todo: implement 'find_by' method to use here
          let(:resource) { @resources.first }

          it "has an identifier" do
            expect(resource.identifier).to eq('I_00001_R')
          end

          it "has a type" do
            expect(resource.type).to eq('webcontent')
          end

          it "has a href" do
            expect(resource.href).to eq('I_00001_R/Learning_Objectives.html')
          end

          it "has files" do
            resource.files.each do |f|
              expect(f).to be_kind_of(CommonCartridge::Elements::Resources::File)
            end
          end

          context "when a quiz" do
            let(:quiz) { @package.quizzes.first }
            it "has question count" do
              expect(quiz.question_count).to eq(11)
            end
          end
        end

        describe Resources::File do
          let(:file) { @resources.first.files.first }

          it "has a href" do
            expect(file.href).to eq("I_00001_R/Learning_Objectives.html")
          end
        end

        describe Resources::Dependency do
          let(:dependency) { @resources[1].dependencies.first }

          it "has an identifierref" do
            expect(dependency.identifierref).to eq("I_00003_R_IMAGERESOURCE")
          end
        end
      end
    end
  end
end
