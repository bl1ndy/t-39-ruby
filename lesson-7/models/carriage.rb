# frozen_string_literal: true

require_relative '../concerns/producable'
require_relative '../concerns/validatable'

class Carriage
  include Producable
  include Validatable

  attr_reader :type, :capacity, :occupied

  def initialize(capacity = nil)
    @type = nil
    @capacity = capacity
    @occupied = 0

    validate!
  end

  def fill(volume = nil)
    @occupied += volume || 1
  end

  def free
    @capacity - @occupied
  end

  private

  def validate!
    raise ArgumentError, 'Please set a carriage capacity' unless @capacity
    raise TypeError, 'Invalid value for carriage capacity!' unless @capacity.is_a?(Integer) || @capacity.is_a?(Float)
  end
end
