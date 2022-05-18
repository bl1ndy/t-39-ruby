# frozen_string_literal: true

require_relative 'station'
require_relative 'route'
require_relative 'train'
require 'minitest/autorun'

class RailroadTest < Minitest::Test
  # rubocop:disable Metrics/MethodLength
  def setup
    @station1 = Station.new 'station1'
    @station2 = Station.new 'station2'
    @station3 = Station.new 'station3'

    @route = Route.new(@station1, @station3)
    @route.include_station @station2

    @train1 = Train.new(1, :cargo, 5)
    @train2 = Train.new(2, :cargo, 10)
    @train3 = Train.new(3, :passenger, 30)

    @train1.take_route @route
    @train2.take_route @route
    @train3.take_route @route
  end
  # rubocop:enable Metrics/MethodLength

  def test_route_has_stations
    assert @route.stations == [@station1, @station2, @station3]
  end

  def test_route_can_exclude_station
    assert @route.exclude_station(@station2)
    assert @route.stations == [@station1, @station3]
  end

  def test_station_has_trains
    assert @station1.trains == [@train1, @train2, @train3]
  end

  def test_trains_on_station_by_type
    assert @station1.trains_by_type == { cargo: 2, passenger: 1 }
  end

  def test_train_has_stations
    assert @train1.current_station == @station1
    assert @train1.next_station == @station2
    refute @train1.prev_station
  end

  def test_train_can_hitch_and_unhitch_carriage
    assert @train1.hitch_carriage
    assert @train1.carriage_count == 6
    assert @train1.unhitch_carriage
    assert @train1.carriage_count == 5
  end

  def test_train_cant_hitch_and_unhitch_carriage_while_moves
    @train1.move_forward

    refute @train1.hitch_carriage
    refute @train1.unhitch_carriage
  end

  def test_train_can_hitch_and_unhitch_carriage_after_stop
    @train1.move_forward
    @train1.stop

    assert @train1.hitch_carriage
    assert @train1.unhitch_carriage
  end

  def test_train_moves_forward
    @train1.move_forward

    assert @train1.current_station == @station2
    assert @station2.trains.include? @train1
    assert @train1.next_station == @station3
    assert @train1.prev_station == @station1
  end

  def test_train_moves_back
    @train1.move_forward
    @train1.move_forward
    @train1.move_back

    assert @train1.current_station == @station2
    assert @station2.trains.include? @train1
    assert @train1.next_station == @station3
    assert @train1.prev_station == @station1
  end

  def test_train_cant_move_back_from_start_station
    refute @train1.move_back
  end

  def test_train_cant_move_forward_from_end_station
    @train1.move_forward
    @train1.move_forward

    refute @train1.move_forward
  end
end
