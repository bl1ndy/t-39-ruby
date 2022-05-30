# frozen_string_literal: true

require_relative '../models/station'
require_relative 'common'

class StationsInterface
  include Common

  def initialize(interface)
    @interface = interface
  end

  def call
    loop do
      if @interface.stations.empty?
        clear_screen
        puts "There are no stations.\n\n"
      else
        show_stations(@interface.stations)
      end

      puts '1: Create new station'
      puts '2: Show trains on station' unless @interface.stations.empty?
      puts '0: Back to navigation'

      input = validate_input(gets.chomp, (0..2))

      case input
      when 1
        create_station
      when 2
        show_stations(@interface.stations)
        puts "1-#{@interface.stations.count}: Choose station"
        puts '0: Back to Stations'
        input = validate_input(gets.chomp, (0..@interface.stations.count))

        next if input.zero?

        show_station(@interface.stations[input - 1])

        puts 'Press any key: Back to Stations'

        next if gets
      else
        break
      end
    end
  end

  private

  def show_stations(list)
    clear_screen
    puts '########### Stations ###########'
    list.each_with_index { |s, i| puts "#{i + 1}: #{s.name}" }
    puts "################################\n\n"
  end

  def show_station(station)
    clear_screen
    puts "Station: #{station.name}\n\n"
    puts '########### Trains ###########'
    station.each_train do |t, i|
      puts "#{i + 1}. Serial: '#{t.serial}' >> Type: '#{t.type.capitalize}' >> Carriages: #{t.carriages.count}"
    end
    puts "##############################\n\n"
  end

  def create_station
    loop do
      clear_screen
      print 'Enter a station name: '

      name = gets.chomp
      @interface.stations << Station.new(name)

      puts "Station '#{name}' successfully created!\n\n"
      puts '1: Create one more station'
      puts '0: Back to Stations'

      input = validate_input(gets.chomp, (0..1))

      break if input.zero?
    end
  end
end
