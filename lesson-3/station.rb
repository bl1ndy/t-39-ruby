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
    @trains.delete_if { |t| t == train }
  end

  def trains_by_type
    @trains.each_with_object({}) do |t, obj|
      obj[t.type] ? obj[t.type] += 1 : obj[t.type] = 1
    end
  end

  # Не совсем понял задание "Может возвращать список
  # поездов на станции по типу: кол-во грузовых, пассажирских".
  # Если имелось в виду вернуть кол-во определенного типа, то:

  # def trains_by_type(type)
  #   @trains.count { |t| t.type == type.to_sym }
  # end
end
