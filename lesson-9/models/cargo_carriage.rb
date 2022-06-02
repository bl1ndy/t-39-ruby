# frozen_string_literal: true

class CargoCarriage < Carriage
  def initialize(capacity)
    super
    @type = :cargo
  end
end
