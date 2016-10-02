require 'optparse'
require_relative 'hero_of_time_inventory'
require 'pry'
#
class MyOptionParser
  def parse_options
    @options = {}

    @parser = OptionParser.new

    parse_help_options

    parse_find_options

    parse_add_options
    #
    # parse_display_options
    #
    # parse_edit_options
    #
    # parse_remove_options

    @parser.parse!

    @options
  end

  def parse_help_options
    @parser.banner = 'How To Run: ruby sql_search_engine.rb option'

    @parser.on('-h', '--help') do
      puts @parser
      # ^ does not print my options...?
      exit
    end
  end

  def parse_find_options
    @parser.on('-f', '--find ITEM') do |item|
      @options[:find] = item
    end
    initiate_other_options
  end

  def parse_add_options
    @parser.on('-a', '--add ITEM') do |item|
      @options[:add] = item
    end
    initiate_other_options
  end

  def parse_display_options
    @parser.on('-d', '--display ITEM') do |item|
      @options[:display] = item
    end
    @options
  end

  def parse_edit_options
    @parser.on('-e', '--edit ITEM') do |item|
      @options[:edit] = item
    end
    initiate_other_options
  end

  def parse_remove_options
    @parser.on('-rm', '--remove ITEM') do |item|
      @options[:remove] = item
    end
    initiate_other_options
  end

  def initiate_other_options
    @parser.on('-t', '--type TYPE') do |type|
      @options[:type] = type
    end
    @parser.on('-s', '--stock STOCK') do |stock|
      @options[:stock] = stock
    end
    @parser.on('-w', '--wielder WIELDER') do |wielder|
      @options[:wielder] = wielder
    end
    @options
  end
end
