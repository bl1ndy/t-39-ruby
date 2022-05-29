# frozen_string_literal: true

require_relative '../concerns/producable'
require_relative '../concerns/instance_counter'
require_relative '../concerns/validatable'

class Train
  include Producable
  include InstanceCounter
  include Validatable

  attr_reader :serial, :speed, :current_station, :type, :carriages

  def initialize(serial = nil)
    raise ArgumentError, 'Serial is already used' if Train.find(serial)

    @serial = serial.to_s
    @speed = 0
    @carriages = []
    @type = nil

    validate!
    register_instance
  end

  def stop
    @speed = 0
  end

  def hitch_carriage(carriage)
    raise ArgumentError, 'Specified carriage is not a Carriage instance' unless carriage.is_a?(Carriage)

    return false unless carriage.type == @type

    @carriages << carriage if @speed.zero?
  end

  def unhitch_carriage(carriage)
    @carriages.delete(carriage) if @speed.zero?
  end

  def take_route(route)
    raise ArgumentError, 'Specified route is not a Route instance' unless route.is_a?(Route)

    @route = route
    @route.start_station.take_train(self)
    @current_station = @route.start_station
  end

  def next_station
    return if @current_station == @route.end_station

    current_station_index = @route.stations.index(@current_station)
    @route.stations[current_station_index + 1]
  end

  def prev_station
    return if @current_station == @route.start_station

    current_station_index = @route.stations.index(@current_station)
    @route.stations[current_station_index - 1]
  end

  def move_forward
    return unless next_station

    @speed = 50
    @current_station.send_train self
    next_station.take_train self
    @current_station = next_station
  end

  def move_back
    return unless prev_station

    @speed = 50
    @current_station.send_train self
    prev_station.take_train self
    @current_station = prev_station
  end

  class << self
    def find(serial)
      all&.detect { |train| train.serial == serial.to_s }
    end
  end

  private

  def validate!
    serial_format = /^[a-zа-я|\d]{3}-*[a-zа-я|\d]{2}$/i
    raise ArgumentError, 'Please set train serial' unless @serial
    raise ArgumentError, 'Serial has invalid format' unless @serial =~ serial_format
  end
end
