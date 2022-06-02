# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize(capacity = nil)
    super
    @type = :passenger
  end
end
