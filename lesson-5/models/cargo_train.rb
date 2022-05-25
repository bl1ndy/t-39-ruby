# frozen_string_literal: true

class CargoTrain < Train
  def initialize(serial)
    super
    @type = :cargo
  end
end
