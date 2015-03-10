module CommonCartridge
  class Package
    attr_accessor :manifest, :outcomes, :assignments

    def initialize
      @assignments = []
    end

    def find_resource(identifier)
      manifest.resources.find { |r| r.identifier == identifier }
    end

    def outcome_groups
      @outcome_groups ||= outcomes ? outcomes.outcome_groups : []
    end

    def all_outcomes
      @all_outcomes ||= outcome_groups.collect { |g| g.outcomes }.flatten
    end

    def modules
      @modules ||= manifest.organization.root_item.items
    end

    def discussions
      @discussions ||= resources_of_type(Elements::Resources::Topic).reject { |d| d.is_announcement? }
    end

    def announcements
      @announcements ||= resources_of_type(Elements::Resources::Topic).select { |d| d.is_announcement? }
    end

    def pages
      @pages ||= begin
                   pages = resources_of_type(Elements::Resources::Page).each do |page|
                     assign_title(page)
                   end
                  filter_pages(pages)
                end
    end


    def quizzes
      @quizzes ||= resources_of_type(Elements::Resources::Assessment).each do |quiz|
                       assign_title(quiz) unless quiz.title
      end
    end


    private
    def filter_pages(pages)
      pages.select do |page|
        (page.href =~ /wiki/ || page.href =~ /html$/) && page.title
      end
    end

    def assign_title(obj)
      if ref = find_item_by_ref(obj.identifier)
        obj.title = ref.title
      end
    end

    def resources_of_type(type)
      manifest.resources.select { |r| r.type =~ type.pattern }
    end

    def find_item_by_ref(ref)
      all_items.detect do |item|
        item.identifierref == ref
      end
    end

    def all_items
      @all_items ||= begin
                       modules.each_with_object([]) do |mod, memo|
                         memo << mod.items
                         mod.items.each do |item|
                           memo << item.items if item.items
                         end
                       end.flatten
                     end
    end



  end
end
