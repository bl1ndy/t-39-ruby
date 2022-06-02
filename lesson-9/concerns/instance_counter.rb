# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def all
      @all ||= []
    end

    private

    attr_writer :instances
  end

  module InstanceMethods
    private

    def register_instance
      self.class.all << self
      self.class.send(:instances=, self.class.all.size)
    end
  end
end
