module CommonCartridge
  module Elements
    module Lom
      class Title
        include SAXMachine

        element 'lomimscc:string', as: :value
        element 'lomimscc:string', value: :language, as: :language

        def to_s; string; end
      end

      class Description
        include SAXMachine

        element 'lomimscc:string', as: :value
        element 'lomimscc:string', value: :language, as: :language

        def to_s; string; end
      end

      class Keyword
        include SAXMachine

        element 'lomimscc:string', as: :value
        element 'lomimscc:string', value: :language, as: :language

        def to_s; string; end
      end

      class CopyrightAndOtherRestrictions
        include SAXMachine

        element :value
      end

      class Rights
        include SAXMachine

        element 'lomimscc:description', as: :description, class: CommonCartridge::Elements::Lom::Description
        element :copyrightAndOtherRestrictions, class: CommonCartridge::Elements::Lom::CopyrightAndOtherRestrictions
      end

      class General
        include SAXMachine

        element 'lomimscc:title', as: :title, class: CommonCartridge::Elements::Lom::Title
        element 'lomimscc:description', as: :description, class: CommonCartridge::Elements::Lom::Description
        elements 'lomimscc:keyword', as: :keywords, class: CommonCartridge::Elements::Lom::Keyword
      end

      class Lom
        include SAXMachine

        element 'lomimscc:general', as: :general, class: CommonCartridge::Elements::Lom::General
        element :rights, class: CommonCartridge::Elements::Lom::Rights
      end
    end
  end
end
