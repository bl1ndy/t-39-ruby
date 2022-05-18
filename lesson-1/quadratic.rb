# frozen_string_literal: true

puts 'Welcome to the world of quadratic equations!'

puts "\n"
puts 'Enter the a.'
a = gets.chomp.to_i

puts "\n"
puts 'Enter the b.'
b = gets.chomp.to_i

puts "\n"
puts 'Enter the c.'
c = gets.chomp.to_i

d = (b**2) - (4 * a * c)

puts "\n"

if d.negative?
  puts 'There are no roots!'
elsif d.zero?
  x = -b / (2 * a)
  puts "D = #{d} and root x = #{x}"
else
  x1 = (-b + Math.sqrt(d)) / (2 * a)
  x2 = (-b - Math.sqrt(d)) / (2 * a)
  puts "D = #{d}, x1 = #{x1.round(2)} and x2 = #{x2.round(2)}"
end
