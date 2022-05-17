# frozen_string_literal: true

cart = {}

puts "What's in your cart?"
puts "\n"

loop do
  puts "Enter the name of product (Type 'stop' if you're done)."
  name = gets.chomp

  break if name == 'stop'

  while name.empty?
    puts 'Invalid data! Please, enter correct name.'
    name = gets.chomp
  end

  puts 'Enter the price'
  price = gets.chomp.to_f

  while price.negative?
    puts 'Invalid data! Please, enter correct price.'
    price = gets.chomp.to_f
  end

  puts 'Enter the product quantity'
  quantity = gets.chomp.to_f

  while quantity <= 0
    puts 'Invalid data! Please, enter correct quantity.'
    quantity = gets.chomp.to_f
  end

  if cart[name]
    cart[name][:count] += quantity
    cart[name][:price] = (cart[name][:price] + price) / 2 # average price for product with same name but another price
  else
    cart[name] = { price: price, count: quantity }
  end
end

return if cart.empty?

cart_total = 0

puts "\n"
p cart
puts '-' * 20

cart.each do |k, v|
  product_total = v[:count] * v[:price]
  cart_total += product_total
  puts "#{k}: total cost is #{product_total} usd"
end

puts '-' * 20
puts "Total cart is #{cart_total} usd"
