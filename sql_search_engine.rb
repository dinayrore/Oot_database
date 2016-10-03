require_relative 'zelda_database'
require_relative 'hero_of_time_inventory'
require_relative 'my_option_parser'
require_relative 'items'

def main
  zdb = ZeldaDatabase.new

  zdb.disable_notices

  zdb.create_table

  inventory = HeroOfTimeInventory.new(zdb)

  items = inventory.find

  options = MyOptionParser.new.parse_options

  # item = Items.new() do not pass things through?
  #
  # item.find_item(options, inventory) if options.key? :find
  #
  # item.add_item(options) if options.key? :add
  #
  # item.display_inventory(inventory) if options.key? :display
  #
  # item.edit_item(options) if options.key? :edit
  #
  # item.remove_item(options) if options.key? :remove
end

main if __FILE__ == $PROGRAM_NAME
