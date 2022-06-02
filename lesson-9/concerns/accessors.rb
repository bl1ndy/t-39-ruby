# frozen_string_literal: true

module Accessors
  # rubocop:disable Metrics/MethodLength
  def attr_accessor_with_history(*args)
    args.each do |arg|
      var_name = "@#{arg}".to_sym
      history = "@#{arg}_history".to_sym

      define_method("#{arg}_history".to_sym) { instance_variable_get(history) }
      define_method(arg) { instance_variable_get(var_name) }
      define_method("#{arg}=".to_sym) do |value|
        instance_variable_set(var_name, value)

        if instance_variable_get(history)
          instance_variable_get(history) << value
        else
          instance_variable_set(history, [value])
        end
      end
    end
  end
  # rubocop:enable Metrics/MethodLength

  def strong_attr_accessor(arg, type)
    var_name = "@#{arg}".to_sym

    define_method(arg) { instance_variable_get(var_name) }
    define_method("#{arg}=".to_sym) do |value|
      raise TypeError, "Specified value is not an instance of #{type}" unless value.is_a?(type)

      instance_variable_set(var_name, value)
    end
  end
end
