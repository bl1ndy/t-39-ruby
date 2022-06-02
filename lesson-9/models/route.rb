# frozen_string_literal: true

require_relative '../concerns/instance_counter'
require_relative '../concerns/validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :start_station, :end_station

  validate :start_station, :presence
  validate :start_station, :type, Station
  validate :end_station, :presence
  validate :end_station, :type, Station

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
end
