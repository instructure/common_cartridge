require 'spec_helper'

module CommonCartridge
  describe Package do
    before(:all) do
      @package = CommonCartridge.parse_from_zip('canvas_large_1.3.imscc')
    end

    describe "#find_resource" do
      it "finds a resource by identifier" do
        resource = @package.find_resource('i4874e552ee3da37b383af53dd9429827_syllabus')
        expect(resource).to be_kind_of(CommonCartridge::Elements::Resources::Resource)
        expect(resource.identifier).to eq('i4874e552ee3da37b383af53dd9429827_syllabus')
        expect(resource.files.size).to be(1)
      end

      it "returns nil if no resource is found" do
        resource = @package.find_resource('NONEXISTENT')
        expect(resource).to be_nil
      end

      context "#modules" do
        it "returns all modules in the course" do
          modules = {'i224aa0e52b019dbf9aeece014df883c7' => 'Example Course Module', 'ibbc4f845ea3211abdd01b7d296a1e835' => 'Example, Locked Module'}

          expect(@package.modules.size).to be(2)
          @package.modules.each do |mod|
            expect(modules).to have_key(mod.identifier)
            expect(modules[mod.identifier]).to eq(mod.title)
          end
        end
      end

      context "#announcements" do
        it "returns all announcements in a course" do
          announcements =  {"i528c2ce0186a758d13a9bd193bd88611"=>"Include Replies in Podcast Feed Announcement Example",
                            "ic5879f637e17f2e475484297bc1b843d"=>"Enable Podcast Feed Example Announcements",
                            "i1686b8be7bc843860fa51754ce47164a"=>"Basic Announcement",
                            "i852220027877f9c75a980885d566e950"=>"Users Must Post Before Seeing Replies Announcement"}

          expect(@package.announcements.size).to be(4)
          @package.announcements.each do |announcement|
            expect(announcements).to have_key(announcement.identifier)
            expect(announcements[announcement.identifier]).to eq(announcement.title)
          end
        end
      end

      context "#discussions" do
        it "returns all discussions in the course" do
          discussions = {"idf59303d98482bfce1042d7960b0dd08"=>"unpublished discussion",
                         "ic7f740de8643c0d8bdbb099edddf5c3b"=>"Closed for Comment Discussion",
                         "i45f927e81657f719963b4d5182ce7b87"=>"Graded Discussion",
                         "i049a4e1050a9ae9112d552c4bb1d927d"=>"Enable Podcast Feed Discussion",
                         "ia4977b4ba7e0b86ddbd48ce8808a108b"=>"Users Must Post Before Seeing Replies",
                         "i8f219f74f06e31465d76b8d53f1c15ce"=>"Include Replies in Podcast Feed Discussion",
                         "i658f87ccf2a665a190f7b684ba8a5d17"=>"Graded Group Discussion Example",
                         "i1a45b26146cf73c8530c039f1c5a6576"=>"Graded Group Discussion, Assign Grades to Each Student Individually",
                         "id82f5aee12aac6c03677da3baac04590"=>"Graded Discussion with Manually Assigned Peer Reviews",
                         "ifac8262aac5c07e2fd1425c21c2ec4db"=>"Graded Discussion with Automatically Assigned Peer Reviews",
                         "ib6df2d84b4dd1cdf6cec87fc54678b37"=>"Threaded Discussion",
                         "ie896adbc712bb119c4e9a1a673f8a673"=>"Non-Threaded Discussion",
                         "i9a5d38abe47ccfaf18da6727564f0d28"=>"Pinned Discussion"}

          expect(@package.discussions.size).to be(13)
          @package.discussions.each do |discussion|
            expect(discussions).to have_key(discussion.identifier)
            expect(discussions[discussion.identifier]).to eq(discussion.title)
          end
        end
      end

      context "#pages" do
        it "returns all pages in the course" do
          expect(@package.pages.size).to be(2)
          expect(@package.pages.first.title).to eq("Front Page")
          expect(@package.pages.last.title).to eq("Page hidden from Students")
        end
      end

      context "#quizzes" do
        it "returns all quizzes in the course" do
          quizzes = {"i7d40ddafe1510b13e094faf1d8aede61"=>"50 Q's straight up tf and mc",
                     "iae800568e436f2368f690a2a87aa92e8"=>"Access code is \"Canvas\" Access Code Example",
                     "i92556d03cef1a20c975b43115011059f"=>"All Question Types with text only (should be 11)",
                     "ib9091a8b64585d919f2397719bf860c3"=>"Graded Anonymous Survey Example",
                     "i86bbc04ca52991f32dc0f9f041b147e9"=>"Graded Survey Example",
                     "iddbfdaac01dadef8fc889dc39ecb9830"=>"Hide Quiz Answers Quiz Example",
                     "i1dee4ce6a2ea508cbad5bca6bb9cdb8f"=>"MC, TF, MA, Essay, FITB 5 q's",
                     "i581ee685674f4a8c9231bd228a92976a"=>"Multiple Attempt Quiz",
                     "i3876e257310e19864b49172a2544bf56"=>"One Question At A Time, Can't Go Back Example",
                     "iad7e264143b9f2ec9dbc71a9d166f6f2"=>"One Question at a time Quiz Example",
                     "i18ee2ad283ef16acf172480ad0e3e514"=>"Practice Quiz Example",
                     "i13b04e02dbb103ae804043c7139d925f"=>"Shuffled Answers Quiz Example",
                     "iec0216ba5240b3b895d1f707dc03be0b"=>"Time Limit Quiz Example",
                     "i569b45ac1ff7388a1416381bc670488b"=>"Ungraded Anonymous Survey Example",
                     "i7a94069ff8e623310830263a426aed7f"=>"Ungraded Survey Example",
                     "i4a339a8425a8a073409188ac7ef5a097"=>"Unnamed Quiz",
                     "ie970b28994395e4ae82d86c22633708d"=>"Unpublished Quiz Example"}

          expect(@package.quizzes.size).to be(17)
          @package.quizzes.each do |quiz|
            expect(quizzes).to have_key(quiz.identifier)
            expect(quizzes[quiz.identifier]).to eq(quiz.title)
          end
        end
      end
    end
  end
end
