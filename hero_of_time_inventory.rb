#
class HeroOfTimeInventory
  def initialize(conn)
    @conn = conn
  end

  def find_items(options, inventory)
    @conn.exec('SELECT id FROM inventory ' \
    "WHERE item = '#{options[:find]}' OR type = '#{options[:type]}' " \
    "OR stock = '#{options[:stock]}' OR wielder = '#{options[:wielder]}' ")
# error no implicit conversion of Symbol or String into Integer
    puts "item: '#{inventory[:display]}' |" \
    "type: '#{inventory[:type]}' | stock: '#{inventory[:stock]}' |" \
    "wielder: '#{inventory[:wielder]}' "
  end

  def add_item(options)
    @conn.exec('INSERT INTO inventory (item, type, stock, wielder) ' \
    "SELECT '#{options[:add]}', '#{options[:type]}', " \
    " '#{options[:stock]}', '#{options[:wielder]}' " \
    'WHERE NOT EXISTS (SELECT id FROM inventory ' \
    "WHERE item = '#{options[:add]}' AND type = '#{options[:type]}' " \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}')")
  end

# same issue as find
  def display_inventory(inventory)
    database = @conn.exec('SELECT * FROM inventory')
    database.each do |item|
      puts "id: #{inventory[:id]} | item: #{inventory[:display]} " \
      "type: #{inventory[:type]} | stock: #{inventory[:stock]} " \
      "wielder: #{inventory[:wielder]}"
    end
  end

# can't seem to figure out how to get this one to work
  def edit_item(options)
    @conn.exec('UPDATE FROM inventory (item, type, stock, wielder)' \
    "WHERE item = '#{options[:edit]}' AND type = '#{options[:type]}' " \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}'")
  end

# error near item `exec': ERROR:  syntax error at or near "("
  def remove_item(options)
    @conn.exec('DELETE FROM inventory(item, type, stock, wielder) ' \
    "WHERE item = '#{options[:remove]}' AND type = '#{options[:type]}' " \
    "AND stock = '#{options[:stock]}' AND wielder = '#{options[:wielder]}')")
  end
end
