# frozen_string_literal: true

require_relative 'models/carriage'

c = Carriage.new(50)

c.a = 10
c.a = 15
c.a = 20
c.d = 140
c.d = -15

puts 'Check attr_accessor_with_history'
puts 'attr_accessor_with_history :a, :d'
puts "\n"
puts 'Carriage.new(50)'
puts "\n"
puts 'c.a = 10'
puts 'c.a = 15'
puts 'c.a = 20'
puts 'c.d = 140'
puts 'c.d = -15'
puts "\n"
puts "a_history is #{c.a_history}"
puts "d_history is #{c.d_history}"
puts "\n"

c.b = '12'

puts 'Check strong_attr_accessor'
puts 'strong_attr_accessor :b, String'
puts "\n"
puts "c.b = '12' - ok"

begin
  c.b = 12
rescue TypeError
  puts 'c.b = 12 - threw exception'
end
