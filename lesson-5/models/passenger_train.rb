# frozen_string_literal: true

class PassengerTrain < Train
  def initialize(serial)
    super
    @type = :passenger
  end
end
