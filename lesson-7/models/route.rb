# frozen_string_literal: true

require_relative '../concerns/instance_counter'
require_relative '../concerns/validatable'

class Route
  include InstanceCounter
  include Validatable

  attr_reader :start_station, :end_station

  def initialize(start = nil, finish = nil)
    @start_station = start
    @end_station = finish
    @inter_stations = []

    validate!
  end

  def include_station(station)
    raise TypeError, 'Specified station is not a Station instance' unless station.is_a?(Station)

    @inter_stations << station
  end

  def exclude_station(station)
    @inter_stations.delete(station)
  end

  def stations
    [@start_station, *@inter_stations, @end_station]
  end

  def show_stations
    stations.each { |s| puts s.name }
  end

  private

  def validate!
    raise ArgumentError, 'Please set end/start stations' unless @start_station && @end_station

    return if @start_station.is_a?(Station) && @end_station.is_a?(Station)

    raise TypeError, 'Specified station(s) is/are not a Station instance(s)'
  end
end
