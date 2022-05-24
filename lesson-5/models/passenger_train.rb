# frozen_string_literal: true

class PassengerTrain < Train
  @instances = 0

  def initialize(serial)
    super
    @type = :passenger
  end
end
