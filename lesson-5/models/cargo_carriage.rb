# frozen_string_literal: true

class CargoCarriage < Carriage
  def initialize
    super
    @type = :cargo
  end
end
