# frozen_string_literal: true

class CargoCarriage < Carriage
  validate :capacity, :presence

  def initialize(capacity = nil)
    super
    @type = :cargo
  end
end
