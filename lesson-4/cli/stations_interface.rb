# frozen_string_literal: true

require_relative '../models/station'

def stations_interface
  loop do
    if @stations.empty?
      clear_screen
      puts "There are no stations.\n\n"
    else
      show_stations(@stations)
    end

    puts '1: Create new station'
    puts '2: Show trains on station' unless @stations.empty?
    puts '0: Back to navigation'

    input = validate_input(gets.chomp, (0..2))

    case input
    when 1
      create_station
    when 2
      show_stations(@stations)
      puts "1-#{@stations.count}: Choose station"
      puts '0: Back to Stations'
      input = validate_input(gets.chomp, (0..@stations.count))

      next if input.zero?

      show_station(@stations[input - 1])

      puts 'Press any key: Back to Stations'

      next if gets
    else
      break
    end
  end
end

def show_stations(list)
  clear_screen
  puts '########### Stations ###########'
  list.each_with_index { |s, i| puts "#{i + 1}: #{s.name}" }
  puts "################################\n\n"
end

def show_station(station)
  clear_screen
  puts "Station: #{station.name}\n\n"
  puts 'Trains:'
  station.trains.each_with_index { |t, i| puts "#{i + 1}: Serial: '#{t.serial}'. Type: '#{t.type}'" }
  puts "\n"
end

def create_station
  loop do
    clear_screen
    print 'Enter a station name: '

    name = gets.chomp
    @stations << Station.new(name)

    puts "Station '#{name}' successfully created!\n\n"
    puts '1: Create one more station'
    puts '0: Back to Stations'

    input = validate_input(gets.chomp, (0..1))

    break if input.zero?
  end
end
