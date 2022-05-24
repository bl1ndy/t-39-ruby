# frozen_string_literal: true

class CargoTrain < Train
  @instances = 0

  def initialize(serial)
    super
    @type = :cargo
  end
end
