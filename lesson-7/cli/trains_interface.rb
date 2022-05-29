# frozen_string_literal: true

require_relative '../models/train'
require_relative '../models/cargo_train'
require_relative '../models/passenger_train'
require_relative '../models/carriage'
require_relative '../models/cargo_carriage'
require_relative '../models/passenger_carriage'
require_relative 'common'

class TrainsInterface
  include Common

  def initialize(interface)
    @interface = interface
  end

  def call
    loop do
      if @interface.trains.empty?
        clear_screen
        puts "There are no trains.\n\n"
      else
        show_trains
      end

      puts '1: Create new train'
      puts '2: Manage trains' unless @interface.trains.empty?
      puts '0: Back to navigation'

      input = validate_input(gets.chomp, (0..2))

      case input
      when 1
        create_train
      when 2
        show_trains
        puts "1-#{@interface.trains.count}: Choose train"
        puts '0: Back to navigation'

        input = validate_input(gets.chomp, (0..@interface.trains.count))

        manage_train(@interface.trains[input - 1])
      else
        break
      end
    end
  end

  private

  def create_train
    loop do
      clear_screen
      puts "Select type of train\n\n"
      puts '1: Cargo'
      puts '2: Passenger'
      puts '0: Back to Trains'

      type = validate_input(gets.chomp, (0..2))

      break if type.zero?

      train = [CargoTrain, PassengerTrain][type - 1]

      clear_screen

      begin
        print 'Enter a train serial: '
        serial = gets.chomp
        @interface.trains << train.new(serial)
      rescue
        puts 'Invalid serial format! Please try again'
        puts "Valid format is: 3 numbers or/and letters, hyphen (unnecessary), 2 numbers or/and letters\n\n"
        retry
      end

      puts "Train '#{serial}' successfully created!\n\n"
      puts '1: Create one more train'
      puts '0: Back to Trains'

      input = validate_input(gets.chomp, (0..1))

      break if input.zero?
    end
  end

  def show_trains
    clear_screen
    puts '############ Trains ############'
    @interface.trains.each_with_index do |t, i|
      puts "#{i + 1}: Serial '#{t.serial}'. Type '#{t.type}'. Current station: #{t.current_station&.name}"
    end
    puts "################################\n\n"
  end

  def manage_train(train)
    loop do
      clear_screen
      puts "Train '#{train.serial}'\n\n"
      puts '1: Manage carriages'
      puts '2: Take route' unless @interface.routes.empty?
      puts '3: Move train' if train.current_station
      puts '0: Back to Trains'

      input = validate_input(gets.chomp, (0..3))

      case input
      when 1
        manage_carriages(train)
      when 2
        show_routes

        puts "1-#{@interface.routes.count}: Choose route to set for train"
        puts '0: Back to Train'

        input = validate_input(gets.chomp, (0..@interface.routes.count))

        next if input.zero?

        train.take_route(@interface.routes[input - 1])
      when 3
        move_train(train)
      else
        break
      end
    end
  end

  def manage_carriages(train)
    loop do
      clear_screen
      puts "Train '#{train.serial}'. Carriages: #{train.carriages.count}\n\n"
      puts '1: Hitch carriage'
      puts '2: Unhitch carriage'
      puts '0: Back to Train'

      input = validate_input(gets.chomp, (0..2))

      case input
      when 1
        carriage = train.type == :cargo ? CargoCarriage.new : PassengerCarriage.new
        train.stop
        train.hitch_carriage(carriage)
      when 2
        clear_screen
        train.carriages.each_with_index { |c, i| puts "#{i + 1}: Id-#{c.object_id}" }
        puts "\n"
        puts "1-#{train.carriages.count}: Choose carriage to unhitch" unless train.carriages.empty?
        puts '0: Back to Train'

        input = validate_input(gets.chomp, (0..train.carriages.count))

        next if input.zero?

        carriage = train.carriages[input - 1]
        train.stop
        train.unhitch_carriage(carriage)
      else
        break
      end
    end
  end

  def move_train(train)
    return unless train.current_station

    loop do
      clear_screen
      puts "You're at the '#{train.current_station.name}' station."
      puts "The next station is '#{train.next_station.name}'." if train.next_station
      puts "The previous station is '#{train.prev_station.name}'." if train.prev_station
      puts "Where do we go?\n\n"
      puts '1: Move forward' if train.next_station
      puts '2: Move back' if train.prev_station
      puts '0: Back to Train'

      input = validate_input(gets.chomp, (0..2))

      case input
      when 1
        train.move_forward
      when 2
        train.move_back
      else
        break
      end
    end
  end
end
