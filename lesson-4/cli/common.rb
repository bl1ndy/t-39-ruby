# frozen_string_literal: true

def validate_input(input, variants)
  until variants.include?(input.to_i) && input.match?(/^\d+$/)
    puts 'Invalid value!'
    input = gets.chomp
  end
  input.to_i
end

def clear_screen
  system 'clear'
end
