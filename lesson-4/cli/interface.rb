# frozen_string_literal: true

require_relative 'stations_interface'
require_relative 'trains_interface'
require_relative 'routes_interface'

class Interface
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
        stations_interface
      when 2
        trains_interface
      when 3
        routes_interface
      else
        exit
      end
    end
  end

  private

  def validate_input(input, variants)
    until variants.include?(input.to_i) && input.match?(/^\d+$/)
      puts 'Invalid value!'
      input = gets.chomp
    end
    input.to_i
  end

  def clear_screen
    system 'clear'
  end
end
