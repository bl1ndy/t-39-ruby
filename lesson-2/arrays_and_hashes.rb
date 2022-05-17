# frozen_string_literal: true

########## unit 1
months = {
  january: 30, february: 28, march: 31,
  april: 30, may: 31, june: 30,
  july: 31, august: 31, september: 30,
  october: 31, november: 30, december: 31
}

months.each do |m|
  name, days = m
  puts name if days == 30
end

puts "\n"

########## unit 2
p (10..100).step(5).to_a
puts "\n"

########## unit 3
fib = [0, 1]

loop do
  break if fib[-2] + fib[-1] > 100

  fib.push(fib[-2] + fib[-1])
end

p fib
puts "\n"

########## unit 4
vowels = %w[a e i o u y]
result = vowels.each_with_object({}) do |v, acc|
  acc[v] = v.ord - 96
end

p result
puts "\n"
