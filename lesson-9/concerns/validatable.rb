# frozen_string_literal: true

module Validatable
  def valid?
    validate!
    true
  rescue ArgumentError, TypeError
    false
  end

  private

  def validate!
    raise "You should initialize method 'validate!' with your own validation logic in class: #{self.class}"
  end
end
