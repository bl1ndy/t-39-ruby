# frozen_string_literal: true

require_relative 'models/station'
require_relative 'models/train'
require_relative 'models/cargo_train'
require_relative 'models/passenger_train'
require_relative 'models/carriage'
require_relative 'models/cargo_carriage'
require_relative 'models/passenger_carriage'
require_relative 'models/route'

6.times { Station.new('station') }
p Station.all
p Station.instances

Train.new '123'
Train.new '345'
Train.all << 'hui'
p Train.all
p Train.instances
p Train.find '123'

