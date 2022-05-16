# frozen_string_literal: true

puts 'Welcome to the Triangle Area Calculator!'

puts "\n"
puts 'Please, enter triangle base (cm).'
base = gets.chomp.to_i

while base <= 0
  puts 'Invalid data! Please, enter the base.'
  base = gets.chomp.to_i
end

puts "\n"
puts 'Please, enter triangle height (cm).'
height = gets.chomp.to_i

while height <= 0
  puts 'Invalid data! Please, enter the height.'
  height = gets.chomp.to_i
end

area = 0.5 * base * height

puts "\n"
puts "Triangle area is #{area.to_i} cm!"
