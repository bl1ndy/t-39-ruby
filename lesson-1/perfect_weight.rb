# frozen_string_literal: true

puts 'Welcome to the Perfect Weight Calculator!'

puts "\n"
puts "What's your name?"
name = gets.chomp

puts "\n"
puts 'Please, enter your height (cm).'
height = gets.chomp.to_i

perfect_weight = ((height - 110) * 1.15).round(1)

answer = if perfect_weight.positive?
           "#{name}, the perfect weight for you is #{perfect_weight} kg."
         else
           "Congrats, #{name}! Your weight is optimal."
         end

puts "\n"
puts answer
