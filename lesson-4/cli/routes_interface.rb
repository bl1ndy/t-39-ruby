# frozen_string_literal: true

require_relative 'common'
require_relative '../models/route'

def routes_interface
  loop do
    if @routes.empty?
      clear_screen
      puts "There are no routes.\n\n"
    else
      show_routes
    end

    puts '1: Create new route' unless @stations.count < 2
    puts '2: Manage route' unless @routes.empty?
    puts '0: Back to navigation'

    input = validate_input(gets.chomp, (0..2))

    case input
    when 1
      create_route
    when 2
      show_routes
      puts "1-#{@routes.count}: Choose route"
      puts '0: Back to navigation'

      input = validate_input(gets.chomp, (0..@routes.count))

      manage_route(@routes[input - 1])
    else
      break
    end
  end
end

def create_route
  loop do
    show_stations(@stations)
    puts "1-#{@stations.count}: Choose start station"
    puts '0: Back to Routes'

    input = validate_input(gets.chomp, (0..@stations.count))

    break if input.zero?

    start_station = @stations[input - 1]

    remain_stations = @stations.reject { |s| s == start_station }
    show_stations(remain_stations)
    puts "1-#{remain_stations.count}: Choose end station"
    puts '0: Back to Routes'

    input = validate_input(gets.chomp, (0..remain_stations.count))

    break if input.zero?

    end_station = remain_stations[input - 1]
    @routes << Route.new(start_station, end_station)

    clear_screen
    puts "Route successfully created!\n\n"
    puts '1: Create one more route'
    puts '0: Back to Routes'

    input = validate_input(gets.chomp, (0..1))

    break if input.zero?
  end
end

def show_routes
  clear_screen
  puts '############ Routes ############'
  @routes.each_with_index do |r, i|
    puts "#{i + 1}: From: '#{r.start_station.name}' to: '#{r.end_station.name}'"
  end
  puts "################################\n\n"
end

def manage_route(route)
  loop do
    clear_screen
    puts "Route from '#{route.start_station.name}' to '#{route.end_station.name}'\n\n"
    puts '1: Manage stations'
    puts '0: Back to Routes'

    input = validate_input(gets.chomp, (0..1))

    case input
    when 1
      manage_stations(route)
    else
      break
    end
  end
end

def add_station(route)
  loop do
    clear_screen
    remain_stations = @stations - route.stations
    show_stations(remain_stations)
    puts "1-#{remain_stations.count}: Choose station to add"
    puts '0: Back to Route'

    input = validate_input(gets.chomp, (0..remain_stations.count))

    break if input.zero?

    route.include_station(remain_stations[input - 1])

    clear_screen
    puts "Station successfully added!\n\n"
    puts '1: Add one more station'
    puts '0: Back to Route'

    input = validate_input(gets.chomp, (0..1))

    break if input.zero?
  end
end

def remove_station(route)
  loop do
    clear_screen
    remain_stations = route.stations - [route.start_station, route.end_station]
    show_stations(remain_stations)
    puts "1-#{remain_stations.count}: Choose station to remove"
    puts '0: Back to Route'

    input = validate_input(gets.chomp, (0..remain_stations.count))

    break if input.zero?

    route.exclude_station(remain_stations[input - 1])

    clear_screen
    puts "Station successfully removed!\n\n"
    puts '1: Remove one more station' unless route.stations.count < 3
    puts '0: Back to Route'

    input = validate_input(gets.chomp, (0..1))

    break if input.zero?
  end
end

def manage_stations(route)
  loop do
    clear_screen
    puts "Route from '#{route.start_station.name}' to '#{route.end_station.name}'\n\n"
    show_stations(route.stations)
    puts '1: Add station'
    puts '2: Remove station' unless route.stations.count < 3
    puts '0: Back to Route'

    input = validate_input(gets.chomp, (0..2))

    case input
    when 1
      add_station(route)
    when 2
      remove_station(route)
    else
      break
    end
  end
end
