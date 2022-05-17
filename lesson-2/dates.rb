# frozen_string_literal: true

def leap?(year)
  return false if year % 4 != 0

  (year % 100).zero? ? (year % 400).zero? : true
end

puts 'Find out serial of date!'
puts "\n"

puts 'Enter a day of the month'
day = gets.chomp.to_i

until (1..31).include? day
  puts 'Invalid data! Please, enter correct value'
  day = gets.chomp.to_i
end

puts 'Enter a serial number of month'
month = gets.chomp.to_i

until (1..12).include? month
  puts 'Invalid data! Please, enter correct value'
  month = gets.chomp.to_i
end

if month == 1
  puts "Serial of date is #{day}!"
  return
end

puts 'Enter a year'
year = gets.chomp.to_i

while day > 28 && month == 2 && !leap?(year)
  puts 'Invalid data! Please, enter a leap year'
  year = gets.chomp.to_i
end

days_in_month = {
  1 => 31, 3 => 31, 4 => 30,
  5 => 31, 6 => 30, 7 => 31,
  8 => 31, 9 => 30, 10 => 31,
  11 => 30, 12 => 31
}

days_in_month[2] = leap?(year) ? 29 : 28

serial = (1...month).to_a.reduce(0) { |sum, m| sum + days_in_month[m] }

puts "Serial of date is #{serial + day}!"
