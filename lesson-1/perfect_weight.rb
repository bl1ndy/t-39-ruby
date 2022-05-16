# frozen_string_literal: true

puts 'Welcome to the Perfect Weight Calculator!'

puts "\n"
puts "What's your name?"
name = gets.chomp

while name.empty?
  puts 'Please, enter your name.'
  name = gets.chomp
end

puts "\n"
puts 'Please, enter your height (cm).'
height = gets.chomp.to_i

while height <= 0
  puts 'Invalid data! Please, enter your height (cm).'
  height = gets.chomp.to_i
end

perfect_weight = ((height - 110) * 1.15).round(1)

answer = if perfect_weight.positive?
           "#{name}, the perfect weight for you is #{perfect_weight} kg."
         else
           "Your weight is optimal, #{name}!"
         end

puts "\n"
puts answer
