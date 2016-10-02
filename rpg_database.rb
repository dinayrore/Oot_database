require 'optparse'
require 'pg'
public

def get_options
  options = {}
  OptionParser.new do |opts|
    opts.on('-a', '--add TASK') do |name|
      options[:add] = name
    end
    opts.on('-r', '--read LIST') do |name|
      options[:read] = name
    end
    opts.on('-e', '--edit FILE') do |name|
      options[:edit] = name
    end
    opts.on('-rm', '--remove ITEM') do |name|
      options[:remove] = name
    end
  end.parse!

  options
end

class RPG
  def add_character(conn, name)
    sql = 'INSERT INTO characters (name)' \
    "SELECT '#{name}' WHERE NOT EXITS" \
    "SELECT id FROM character WHERE name = '#{name}'" \
    ');'
    conn.exec(sql)
  end

  def read_character_list(conn, name)
    database = conn.exec('SELECT * FROM characters')
    database.each do |character|
      puts "id: #{character['id']} | name: #{character['name']}"
    end
  end

  def edit_character(conn, name)

  end

  def remove_character(conn, name)

  end
end

def disable_notices(conn)
  conn.exec('SET client_min_messages TO WARNING;')
end

def create_characters_table(conn)
  conn.exec(
    'CREATE TABLE IF NOT EXISTS characters (' \
    'id SERIAL PRIMARY KEY,' \
    'name VARCHAR)'
  )
end

def main
  options = get_options

  conn = PG.connect(dbname: 'rpg')

  disable_notices(conn)

  create_characters_table(conn)

  character = RPG.new

  character.add_character(conn, options[:add]) if options.key? :add

  character.read_character_list(conn, options[:read]) if options.key? :read

  character.edit_character(conn, options[:edit]) if options.key? :edit

  character.remove_character(conn, options[:remove]) if options.key? :remove
end

main if __FILE__ == $PROGRAM_NAME
