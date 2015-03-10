module CommonCartridge
  module Elements
    class Metadata
      include SAXMachine

      element :schema
      element :schemaversion

      element :lom, class: CommonCartridge::Elements::Lom::Lom
    end
  end
end
