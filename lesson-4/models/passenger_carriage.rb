# frozen_string_literal: true

class PassengerCarriage < Carriage
  def initialize
    super
    @type = :passenger
  end
end
