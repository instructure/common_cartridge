module CommonCartridge
  module Elements
    class Metadata
      include SAXMachine

      element :schema
      element :schemaversion

      element 'lomimscc:lom', as: :lom, class: CommonCartridge::Elements::Lom::Lom
    end
  end
end
