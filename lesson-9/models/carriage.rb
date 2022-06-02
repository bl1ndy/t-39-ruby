# frozen_string_literal: true

require_relative '../concerns/producable'
require_relative '../concerns/accessors'
require_relative '../concerns/validation'

class Carriage
  include Producable
  extend Accessors
  include Validation

  attr_reader :type, :capacity, :occupied

  attr_accessor_with_history :a, :d
  strong_attr_accessor :b, String

  validate :capacity, :presence
  validate :capacity, :type, Integer

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
end
