require 'spec_helper'

module CommonCartridge
  module Elements
    module Resources
      describe BasicLTILink do
        before(:all) do
          manifest = CommonCartridge.parse_from_zip('canvas_small_1.1.imscc').manifest
          @resource = manifest.resources.detect { |r| r.identifier =~ /I_00015_R/ }
        end

        it "is parsed correctly" do
          expect(@resource.files.first.content).to be_kind_of(CommonCartridge::Elements::Resources::BasicLTILink)
        end

        it "has a title" do
          expect(@resource.files.first.content.title).to eq('Semester 1 Overview')
        end

        it "has a secure_launch_url" do
          expect(@resource.files.first.content.secure_launch_url).to eq('https://fakecollege.com/activity_lists/student-resources--122/activities/semester-1-overview--17?custom_course_id=275')
        end
      end
    end
  end
end

