# frozen_string_literal: true

require_relative '../concerns/producable'

class Carriage
  include Producable

  attr_reader :type

  def initialize
    @type = nil
  end
end
