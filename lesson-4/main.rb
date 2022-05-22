# frozen_string_literal: true

require_relative 'cli/stations_interface'
require_relative 'cli/trains_interface'
require_relative 'cli/routes_interface'

##### Demo-data - uncomment if don't want create items #####
# s1 = Station.new('s1')
# s2 = Station.new('s2')
# s3 = Station.new('s3')
# s4 = Station.new('s4')
# s5 = Station.new('s5')
#
# r1 = Route.new(s1, s5)
# r2 = Route.new(s2, s5)
#
# t1 = CargoTrain.new('123')
# t2 = CargoTrain.new('321')
# t3 = PassengerTrain.new('456')

# @stations = [s1, s2, s3, s4, s5]
# @routes = [r1, r2]
# @trains = [t1, t2, t3]

@stations = []
@routes = []
@trains = []

loop do
  clear_screen
  puts "Welcome to RailRoad control panel\n\n"
  puts '1: Stations'
  puts '2: Trains'
  puts '3: Routes' unless @stations.count < 2
  puts '0: Exit'

  input = validate_input(gets.chomp, (0..3))

  case input
  when 1
    stations_interface
  when 2
    trains_interface
  when 3
    routes_interface
  else
    exit
  end
end
