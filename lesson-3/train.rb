# frozen_string_literal: true

class Train
  attr_reader :serial, :type, :carriage_count, :speed, :current_station

  CARRIAGE_TYPES = %i[cargo passenger].freeze

  def initialize(serial, type = :cargo, carriage_count = 0)
    @serial = serial
    @type = type.to_sym
    @carriage_count = carriage_count
    @speed = 0

    raise 'Invalid train type' unless CARRIAGE_TYPES.include?(@type)
    raise 'Invalid carriage count value' unless @carriage_count.is_a?(Integer)
  end

  def stop
    @speed = 0
  end

  def hitch_carriage
    @carriage_count += 1 if @speed.zero?
  end

  def unhitch_carriage
    @carriage_count -= 1 if @speed.zero?
  end

  def take_route(route)
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
end
