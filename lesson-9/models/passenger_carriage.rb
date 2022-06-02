# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize(capacity)
    super
    @type = :passenger
  end
end
