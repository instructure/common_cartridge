# common_cartridge
A gem for the parsing of IMS Common Cartridge bundles.

## Usage

CommonCartridge transforms the XML contained in a Common Cartridge zip file into a nested object representation.

``` ruby
require 'common_cartridge'

manifest = CommonCartridge.parse_from_zip('location/to/common/cartridge/zip/file')
puts manifest.metadata.schema
# => "IMS Common Cartridge"

puts manifest.metadata.schemaversion
# => "1.1.0"

# Get title of course
puts manifest.lom.general.title
# => "Art History 101"

# Get all associated resource types (discussion topics, assignments, etc)
resource_types = manifest.resources.map { |r| r.type }
puts resource_types
# => ['webcontent', 'imsdt', 'webcontent', 'assignment', 'webcontent', 'imsdt']

puts manifest.resources.first.title
# => "Portrait of Pablo Picasso"
```

You can also parse a Common Cartridge manifest XML file that's already been extracted.
``` ruby
xml = File.open('imsmanifest.xml').read

CommonCartridge::Parser.parse(xml)
```

You can configure cartridge as well.

``` ruby
CommonCartridge.configure do |c|
  # import_directory is where CommonCartridge.parse_from_zip scopes to.
  c.import_directory = '/home/me/courses' # defaults to '.'

  # no-op currently, until resource parsing is done.
  c.export_directory = '/home/me/outputs' # defaults to '/tmp'
end
```

