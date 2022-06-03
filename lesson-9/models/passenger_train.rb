# frozen_string_literal: true

class PassengerTrain < Train
  validate :serial, :presence
  validate :serial, :format, SERIAL_FORMAT

  def initialize(serial = nil)
    super
    @type = :passenger
  end
end
