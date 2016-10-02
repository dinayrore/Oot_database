require 'pry'
#
class HeroOfTimeInventory
  def initialize(conn)
    @conn = conn
  end

  def find_items(options)
    @conn.exec('SELECT * FROM inventory ORDER BY' \
    "('SELECT id FROM inventory" \
    "WHERE item = '#{options[:find]}' OR type = '#{options[:type]}'" \
    "OR stock = '#{options[:stock]}' OR wielder = '#{options[:wielder]}')")

    puts "id: #{inventory[:id]} | item: #{inventory[:display]} " \
    "type: #{inventory[:type]} | stock: #{inventory[:stock]} " \
    "wielder: #{inventory[:wielder]}"
  end

  def add_item(options)
    @conn.exec('INSERT INTO inventory (item, type, stock, wielder) ' \
    "SELECT '#{options[:add]}', '#{options[:type]}', " \
    " '#{options[:stock]}', '#{options[:wielder]}' " \
    'WHERE NOT EXISTS (SELECT id FROM inventory ' \
    "WHERE item = '#{options[:add]}' AND type = '#{options[:type]}' " \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}')")
  end

  def display_inventory(options)
    database = @conn.exec('SELECT * FROM inventory')
    database.each do |item|
      puts "id: #{inventory[:id]} | item: #{inventory[:display]} " \
      "type: #{inventory[:type]} | stock: #{inventory[:stock]} " \
      "wielder: #{inventory[:wielder]}"
    end
  end

  def edit_item(options)
    @conn.exec('UPDATE FROM inventory (item, type, stock, wielder)' \
    "WHERE item = '#{options[:edit]}' AND type = '#{options[:type]}' " \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}'")
  end

  def remove_item(options)
    @conn.exec('DELETE FROM inventory (item, type, stock, wielder)' \
    "WHERE item = '#{options[:remove]}' AND type = '#{options[:type]}'" \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}')")
  end
end
