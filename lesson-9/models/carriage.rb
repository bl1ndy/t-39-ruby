# frozen_string_literal: true

require_relative '../concerns/producable'
require_relative '../concerns/validatable'
require_relative '../concerns/accessors'

class Carriage
  include Producable
  include Validatable
  extend Accessors

  attr_reader :type, :capacity, :occupied

  attr_accessor_with_history :a, :d
  strong_attr_accessor :b, String

  def initialize(capacity = nil)
    @type = nil
    @capacity = capacity
    @occupied = 0

    validate!
  end

  def fill(volume = nil)
    result = @occupied + (volume || 1)

    return if result > @capacity

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
