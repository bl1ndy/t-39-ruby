# frozen_string_literal: true

class Station
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
end
