# frozen_string_literal: true

puts 'Find out triangle type!'

puts "\n"
puts 'Enter the first side please (cm).'
first = gets.chomp.to_i

while first <= 0
  puts 'Invalid data! Please, enter the correct value.'
  first = gets.chomp.to_i
end

puts "\n"
puts 'Enter the second side please (cm).'
second = gets.chomp.to_i

while second <= 0
  puts 'Invalid data! Please, enter the correct value.'
  second = gets.chomp.to_i
end

puts "\n"
puts 'Enter the third side please (cm).'
third = gets.chomp.to_i

while third <= 0
  puts 'Invalid data! Please, enter the correct value.'
  third = gets.chomp.to_i
end

cathetus1, cathetus2, hypo = [first, second, third].sort

type = if hypo**2 == (cathetus1**2) + (cathetus2**2)
         'right'
       elsif hypo == cathetus1 && hypo == cathetus2 && cathetus1 == cathetus2
         'equilateral and isosceles'
       elsif hypo == cathetus1 || hypo == cathetus2 || cathetus1 == cathetus2
         'isosceles'
       else
         'scalene'
       end

puts "\n"
puts "Your triangle is #{type}!"
