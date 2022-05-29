# frozen_string_literal: true

module Producable
  def manufacturer=(producer)
    self.producer = producer
  end

  def manufacturer
    producer
  end

  private

  attr_accessor :producer
end
