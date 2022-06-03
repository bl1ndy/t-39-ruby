# frozen_string_literal: true

class PassengerCarriage < Carriage
  validate :capacity, :presence

  def initialize(capacity = nil)
    super
    @type = :passenger
  end
end
