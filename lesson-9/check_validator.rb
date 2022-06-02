# frozen_string_literal: true

require_relative 'models/carriage'
require_relative 'models/cargo_carriage'
require_relative 'models/train'
require_relative 'models/station'
require_relative 'models/route'

c = Carriage.new(50)

puts 'Check presence'
puts "\n"
puts 'c1 = Carriage.new(50)'
puts "Result of 'valid?' is #{c.valid?}"
puts 'c2 = Carriage.new'

begin
  Carriage.new
rescue ArgumentError => e
  puts "Get exception - #{e.message}"
  puts "\n"
end

t = Train.new('123-12')

puts 'Check format'
puts "\n"
puts "t1 = Train.new('123-12')"
puts "Result of 'valid?' is #{t.valid?}"
puts "t2 = Train.new('0001034')"

begin
  Train.new('0001034')
rescue ArgumentError => e
  puts "Get exception - #{e.message}"
  puts "\n"
end

s1 = Station.new('s1')
s2 = Station.new('s2')
r = Route.new(s1, s2)

puts 'Check format'
puts "\n"
puts "s1 = Station.new('s1')"
puts "s2 = Station.new('s2')"
puts 'r1 = Route.new(s1, s2)'
puts "Result of 'valid?' is #{r.valid?}"
puts "r2 = Route.new('not_station1', 'not_station2')"

begin
  Route.new('not_station1', 'not_station2')
rescue TypeError => e
  puts "Get exception - #{e.message}"
  puts "\n"
end

cc = CargoCarriage.new(50)

puts 'Check subclasses'
puts "\n"
puts 'cc = CargoCarriage.new(50)'
puts "Result of 'valid?' is #{cc.valid?}"
