# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def instances
      ObjectSpace.each_object(self).to_a.count
    end
  end

  module InstanceMethods
    private

    # Не понял смысла данного метода, поэтому сделал его пустым
    # ради тренировки подключения модуля с непубличными инстанс-методами
    def register_instance; end
  end
end
