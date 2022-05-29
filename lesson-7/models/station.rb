# frozen_string_literal: true

require_relative '../concerns/instance_counter'
require_relative '../concerns/validatable'

class Station
  include InstanceCounter
  include Validatable

  attr_reader :name, :trains

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

  private

  def validate!
    raise ArgumentError, 'Please set station name' unless @name =~ /.+/
  end
end
