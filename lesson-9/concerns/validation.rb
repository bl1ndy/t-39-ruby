# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validations
      @validations || []
    end

    def validate(attr, condition, param = nil)
      validation = { attr: attr, condition: condition, param: param }
      instance_variable_set(:@validations, validations.push(validation))
    end
  end

  module InstanceMethods
    def validate!
      self.class.validations.each { |v| check(v) }
    end

    # rubocop:disable Metrics/CyclomaticComplexity
    def check(validation)
      attr, condition, param = validation.values
      value = instance_variable_get("@#{attr}".to_sym)

      case condition
      when :presence
        raise ArgumentError, "'#{attr}' can't be blank" if value.nil? || value.to_s.strip.empty?
      when :format
        raise ArgumentError, "'#{attr}' has invalid format" unless value =~ param
      when :type
        raise TypeError, "'#{attr}' has invalid type" unless value.is_a?(param)
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity

    def valid?
      validate!
      true
    rescue ArgumentError, TypeError
      false
    end
  end
end
