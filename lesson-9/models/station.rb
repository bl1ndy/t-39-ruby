# frozen_string_literal: true

require_relative '../concerns/instance_counter'
require_relative '../concerns/validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  validate :name, :presence

  def initialize(name = nil)
    @name = name.to_s
    @trains = []

    validate!
    register_instance
  end

  def take_train(train)
    raise TypeError, 'Specified train is not a Train instance' unless train.is_a?(Train)

    @trains << train
  end

  def send_train(train)
    @trains.delete(train)
  end

  def trains_list_by_type(type)
    @trains.select { |t| t.type == type.to_sym }
  end

  def trains_count_by_type(type)
    @trains.count { |t| t.type == type.to_sym }
  end

  def each_train(&block)
    @trains.each_with_index(&block)
  end
end
