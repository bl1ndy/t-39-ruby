# frozen_string_literal: true

class CargoCarriage < Carriage
  def initialize(capacity = nil)
    super
    @type = :cargo
  end
end
