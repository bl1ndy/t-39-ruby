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

    # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    def check(validation)
      value = instance_variable_get("@#{validation[:attr]}".to_sym)

      case validation[:condition]
      when :presence
        raise ArgumentError, "'#{validation[:attr]}' can't be blank" if value.nil? || value.to_s.strip.empty?
      when :format
        raise ArgumentError, "'#{validation[:attr]}' has invalid format" unless value =~ validation[:param]
      when :type
        raise TypeError, "'#{validation[:attr]}' has invalid type" unless value.is_a?(validation[:param])
      end
    end
    # rubocop:enable Metrics/AbcSize, Metrics/CyclomaticComplexity

    def valid?
      validate!
      true
    rescue ArgumentError, TypeError
      false
    end
  end
end
