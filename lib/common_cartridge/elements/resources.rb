require 'common_cartridge/elements/resources/attachments'
require 'common_cartridge/elements/resources/web_link'
require 'common_cartridge/elements/resources/topic'
require 'common_cartridge/elements/resources/assignment'
require 'common_cartridge/elements/resources/assessment'
require 'common_cartridge/elements/resources/page'
require 'common_cartridge/elements/resources/basic_lti_link'

module CommonCartridge
  module Elements
    module Resources

    def self.type_mappings
      {
       Topic.pattern => Topic,
       WebLink.pattern =>  WebLink,
       Assignment.pattern => Assignment,
       Assessment.pattern => Assessment,
       Page.pattern => Page,
       BasicLTILink.pattern => BasicLTILink
      }
    end


      class Content
        include SAXMachine

        element :title
        element :points_possible
        element :type
      end

      class Dependency
        attr_writer :contents

        include SAXMachine
        attribute :identifierref

        def contents
          @contents ||= []
        end

        def title
          if c = contents.detect { |content| !content.title.to_s.empty? }
            return c.title
          end
        end

        def points_possible
          if c = contents.detect { |content| !content.points_possible.to_s.empty? }
            return c.points_possible
          end
        end
      end

      class File
        attr_accessor :content

        include SAXMachine
        attribute :href
        element :attachments, class: Attachments::RootAttachment, as: :attachment_root
        elements :dependency, class: Dependency, as: :dependencies

        def attachments; attachment_root.attachments; end
      end

      class Resource
        attr_accessor :question_count
        attr_writer :title, :points_possible

        include SAXMachine
        attribute :identifier
        attribute :type
        attribute :href
        attribute :intendeduse

        elements :file, class: File, as: :files
        elements :dependency, class: Dependency, as: :dependencies


        # Switch statement based on 'type'
        def points_possible
          @points_possible ||= if dependency = dependencies.detect { |d| d.points_possible && !d.points_possible.empty? }
            dependency.points_possible
          end
        end

        def title
          @title ||= if file = files.detect { |f| f.content && f.content.title && !f.content.title.empty? }
                       file.content.title
                     elsif dependency = dependencies.detect { |d| d.title && !d.title.empty? }
                       dependency.title
                     end
        end

        def file_locations
          [
            ::File.join(identifier, "assessment.xml"),
            ::File.join(identifier, "assessment_qti.xml"),
            ::File.join("non_cc_assessments", "#{identifier}.xml"),
            ::File.join("non_cc_assessments", "#{identifier}.xml.qti")
          ]
        end

        def is_announcement?
          !!dependencies.collect(&:contents).flatten.detect { |c| c.type == 'announcement' }
        end
      end

      class RootResource
        include SAXMachine

        elements :resource, class: Resource, as: :resources

      end

    end
  end
end
