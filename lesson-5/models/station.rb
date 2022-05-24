# frozen_string_literal: true

require_relative '../concerns/instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
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

  class << self
    def all
      ObjectSpace.each_object(self).to_a.reverse
    end
  end
end
