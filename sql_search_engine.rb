require 'pg'
require_relative 'my_option_parser'

def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;')
end

def create_table(conn)
  conn.exec(
    'CREATE TABLE IF NOT EXISTS inventory (' \
    'id SERIAL PRIMARY KEY,' \
    'item VARCHAR, type VARCHAR,' \
    'stock VARCHAR, wielder VARCHAR)'
  )
end

def find_inventory(conn)
  conn.exec('SELECT * FROM inventory')
end

def main
  conn = PG.connect(dbname: 'lonk')

  disable_notices(conn)

  create_table(conn)

  options = MyOptionParser.new.parse_options

  item = HeroOfTimeInventory.new(conn)

  inventory = find_inventory(conn)

  item.find_items(options, inventory) if options.key? :find

  item.add_item(options) if options.key? :add

  item.display_inventory(inventory) if options.key? :display

  item.edit_item(options) if options.key? :edit

  item.remove_item(options) if options.key? :remove
end

main if __FILE__ == $PROGRAM_NAME
