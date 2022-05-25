# frozen_string_literal: true

require_relative '../concerns/instance_counter'

class Route
  include InstanceCounter

  attr_reader :start_station, :end_station

  def initialize(start, finish)
    @start_station = start
    @end_station = finish
    @inter_stations = []
  end

  def include_station(station)
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
