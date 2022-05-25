# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    attr_reader :instances

    def all
      @all
    end

    private

    attr_writer :instances, :all
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instances ? self.class.send(:instances=, self.class.instances + 1)
                           : self.class.send(:instances=, 1)
      self.class.all ? self.class.all << self
                     : self.class.send(:all=, [self])
    end
  end
end
