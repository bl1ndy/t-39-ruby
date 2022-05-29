# frozen_string_literal: true

require_relative 'stations_interface'
require_relative 'trains_interface'
require_relative 'routes_interface'
require_relative 'common'

class Interface
  include Common

  attr_accessor :stations, :trains, :routes

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def call
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
        StationsInterface.new(self).call
      when 2
        TrainsInterface.new(self).call
      when 3
        RoutesInterface.new(self).call
      else
        exit
      end
    end
  end
end
