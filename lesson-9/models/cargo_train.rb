# frozen_string_literal: true

class CargoTrain < Train
  validate :serial, :presence
  validate :serial, :format, SERIAL_FORMAT

  def initialize(serial = nil)
    super
    @type = :cargo
  end
end
